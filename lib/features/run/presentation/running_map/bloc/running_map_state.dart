part of 'running_map_bloc.dart';

@immutable
abstract class RunningMapState extends Equatable {}

class RunningMapInitial extends RunningMapState {
  @override
  List<Object?> get props => [];
}

class RunningMapErrorState extends RunningMapState {
  RunningMapErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}

@immutable
class RunningMapAvailableState extends RunningMapState {
  RunningMapAvailableState(
      {required this.currentPosition,
      this.points = const [],
      this.isRunning = false,
      this.duration = const Duration(),
      this.distance = 0,
      this.avgPace = const Duration(),
      this.kcal = 0,
      this.icon,
      this.speeds = const []});

  final Position currentPosition;
  final List<LatLng> points;
  final bool isRunning;
  final Duration duration;
  final double distance;
  final Duration avgPace;
  final double kcal;
  final BitmapDescriptor? icon;
  final List<double> speeds;

  @override
  List<Object?> get props =>
      [currentPosition, isRunning, points, duration, distance, avgPace, kcal, speeds];

  RunningMapAvailableState copyWith(
      {Position? currentPosition,
      List<LatLng>? points,
      bool? isRunning,
      Duration? duration,
      double? distance,
      Duration? avgPace,
      double? kcal,
      BitmapDescriptor? icon,
      List<double>? speeds}) {
    return RunningMapAvailableState(
        currentPosition: currentPosition ?? this.currentPosition,
        points: points ?? this.points,
        isRunning: isRunning ?? this.isRunning,
        duration: duration ?? this.duration,
        distance: distance ?? this.distance,
        avgPace: avgPace ?? this.avgPace,
        kcal: kcal ?? this.kcal,
        icon: icon ?? this.icon,
        speeds: speeds ?? this.speeds);
  }
}
