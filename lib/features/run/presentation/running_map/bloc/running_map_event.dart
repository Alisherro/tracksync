import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class RunningMapEvent {}

class InitPermissions extends RunningMapEvent {
  InitPermissions();
}

class MapCreated extends RunningMapEvent {
  MapCreated({required this.controller});

  final GoogleMapController controller;
}

class PositionChanged extends RunningMapEvent {
  PositionChanged({required this.position});

  final Position position;
}

class TimerTicked extends RunningMapEvent {
  TimerTicked({required this.duration});

  final Duration duration;
}

class RunButtonTapped extends RunningMapEvent {
  final BuildContext context;
  RunButtonTapped(this.context);
}
