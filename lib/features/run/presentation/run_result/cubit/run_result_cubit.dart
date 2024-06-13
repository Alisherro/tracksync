import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/core/core.dart';

import '../../../../../dependencies_injection.dart';
import '../../../domain/entities/run_result.dart';
import '../../../domain/repositories/run_result_repository.dart';

part 'run_result_state.dart';

class RunResultCubit extends Cubit<RunResultState> {
  RunResultCubit(this.resultID) : super(RunResultInitial());
  final String resultID;

  late GoogleMapController _controller;
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  RunResultRepository get _repo => sl<RunResultRepository>();

  Future<void> initState() async {
    final RunResult? result = await _repo.getRunResultById(resultID);
    if (result == null) {
      emit(RunResultError());
    } else {
      emit(RunResultSuccess(result: result));
    }
  }

  Future<void> mapCreated(GoogleMapController controller) async {
    if (state is RunResultSuccess) {
      mapController.complete(controller);
      GoogleMapController googleMapController = await mapController.future;
      _controller = googleMapController;
      final result = (state as RunResultSuccess).result;
      if (result.points?.isNotEmpty ?? false) {
        var bounds = _boundsFromLatLngList(result.points!);
        var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
        _controller.animateCamera(cameraUpdate);
      }
      Polyline polyline = Polyline(
        polylineId: const PolylineId("route"),
        color: Palette.blueLatte,
        points: result.points
                ?.map((e) => LatLng(e.latitude!, e.longitude!))
                .toList() ??
            [],
        width: 5,
      );

      emit(RunResultSuccess(result: result, polylines: {polyline}));
    }
  }

  LatLngBounds _boundsFromLatLngList(List<PointLatLng> list) {
    double? x0, x1, y0, y1;
    for (PointLatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude! > x1!) x1 = latLng.latitude;
        if (latLng.latitude! < x0) x0 = latLng.latitude;
        if (latLng.longitude! > y1!) y1 = latLng.longitude;
        if (latLng.longitude! < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        southwest: LatLng(x0!, y0!), northeast: LatLng(x1!, y1!));
  }
  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
