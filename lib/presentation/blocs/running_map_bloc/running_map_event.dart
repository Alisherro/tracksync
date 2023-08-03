part of 'running_map_bloc.dart';

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
