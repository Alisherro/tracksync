import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracksync/core/core.dart';
import 'package:tracksync/features/run/presentation/running_map/bloc/running_map_event.dart';

import '../../../domain/entities/run_result.dart';
import '../../../domain/repositories/run_result_repository.dart';

part 'running_map_state.dart';

class Ticker {
  const Ticker();

  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x + 1);
  }
}

class RunningMapBloc extends Bloc<RunningMapEvent, RunningMapState> {
  RunningMapBloc(this._repo) : super(RunningMapInitial()) {
    on<InitPermissions>(_onInitPermissions);
    on<MapCreated>(_mapCreated);
    on<PositionChanged>(_positionChanged);
    on<RunButtonTapped>(_runButtonTapped);
    on<TimerTicked>(_timerTicked);
  }

  final RunResultRepository _repo;
  late Position position;
  late GoogleMapController controller;
  bool isRunning = false;
  final Ticker _ticker = const Ticker();
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  BitmapDescriptor? icon;
  final geolocatorStreamProvider = Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    ),
  );
  StreamSubscription<Position>? _positionSubscription;
  StreamSubscription<int>? _tickerSubscription;

  _timerTicked(TimerTicked event, emit) {
    emit(
      (state as RunningMapAvailableState).copyWith(
        duration: event.duration,
      ),
    );
  }

  _runButtonTapped(RunButtonTapped event, Emitter<RunningMapState> emit) async {
    isRunning = !isRunning;
    if (isRunning) {
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick().listen((event) {
        add(TimerTicked(duration: Duration(seconds: event)));
      });
    } else {
      _tickerSubscription?.cancel();
      final currentState = (state as RunningMapAvailableState);
      int? id;
      id = await _repo.saveRunResult(
        RunResult()
          ..totalSeconds = currentState.duration.inSeconds
          ..points = currentState.points
              .map((e) => PointLatLng()
                ..latitude = e.latitude
                ..longitude = e.longitude)
              .toList()
          ..dateTime = DateTime.now()
          ..kcal = currentState.kcal
          ..distance = currentState.distance
          ..avgPaceSeconds = currentState.avgPace.inSeconds,
      );
      event.context.go('/health/result/$id');
      emit(
        (state as RunningMapAvailableState).copyWith(
          isRunning: isRunning,
          duration: const Duration(),
          distance: 0,
          kcal: 0,
          avgPace: const Duration(),
        ),
      );
    }
    emit(
      (state as RunningMapAvailableState).copyWith(
        points: [
          LatLng((state as RunningMapAvailableState).currentPosition.latitude,
              (state as RunningMapAvailableState).currentPosition.longitude)
        ],
        currentPosition: (state as RunningMapAvailableState).currentPosition,
        isRunning: isRunning,
      ),
    );
  }

  double calculateDistance(LatLng first, LatLng second) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((second.latitude - first.latitude) * p) / 2 +
        cos(first.latitude * p) *
            cos(second.latitude * p) *
            (1 - cos((second.longitude - first.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  _positionChanged(PositionChanged event, Emitter<RunningMapState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int weight = prefs.getInt('weight') ?? 0;
    if (isRunning) {
      emit(
        (state as RunningMapAvailableState).copyWith(
          icon: icon,
          currentPosition: event.position,
          points: List.from((state as RunningMapAvailableState).points)
            ..add(
              LatLng(event.position.latitude, event.position.longitude),
            ),
          isRunning: true,
          distance: (state as RunningMapAvailableState).distance +
              calculateDistance((state as RunningMapAvailableState).points.last,
                  LatLng(event.position.latitude, event.position.longitude)),
          kcal: weight *
              ((state as RunningMapAvailableState).distance +
                  calculateDistance(
                      (state as RunningMapAvailableState).points.last,
                      LatLng(
                          event.position.latitude, event.position.longitude))),
          avgPace: Duration(
            seconds: (state as RunningMapAvailableState).duration.inSeconds ~/
                ((state as RunningMapAvailableState).distance +
                    calculateDistance(
                      (state as RunningMapAvailableState).points.last,
                      LatLng(
                        event.position.latitude,
                        event.position.longitude,
                      ),
                    )),
          ),
        ),
      );
    } else {
      emit(
        (state as RunningMapAvailableState).copyWith(
          isRunning: false,
          points: [],
          currentPosition: event.position,
          distance: 0,
          kcal: 0,
          icon: icon,
        ),
      );
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }

  _mapCreated(MapCreated event, Emitter<RunningMapState> emit) async {
    final Uint8List markerIcon = await getBytesFromAsset(Images.runningBluePng, 100);
    // icon= await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), Images.runningBluePng);
    icon = BitmapDescriptor.fromBytes(markerIcon);
    mapController.complete(event.controller);
    GoogleMapController googleMapController = await mapController.future;
    controller = googleMapController;
    _positionSubscription = geolocatorStreamProvider.listen(
      (event) async {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(event.latitude, event.longitude),
            ),
          ),
        );
        add(PositionChanged(position: event));
      },
    );
  }

  _onInitPermissions(event, Emitter<RunningMapState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(RunningMapErrorState(error: 'Location services are disabled'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(RunningMapErrorState(error: 'Location permissions are denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        RunningMapErrorState(
          error:
              'Location permissions are permanently denied, we cannot request permissions',
        ),
      );
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try{
        position = await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 10));
        emit(RunningMapAvailableState(currentPosition: position));
      }on LocationServiceDisabledException{
        emit(RunningMapErrorState(error: 'location services of the device are disabled'));
      } on TimeoutException{
        emit(RunningMapErrorState(error: 'Some errors with your geolocator service'));
      }
    }
  }

  @override
  Future<void> close() async {
    await _tickerSubscription?.cancel();
    await _positionSubscription?.cancel();
    return super.close();
  }
}
