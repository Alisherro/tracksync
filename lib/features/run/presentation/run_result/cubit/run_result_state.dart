part of 'run_result_cubit.dart';

@immutable
abstract class RunResultState {}

class RunResultInitial extends RunResultState {}

class RunResultSuccess extends RunResultState {
  RunResultSuccess({required this.result, this.polylines});

  final RunResult result;
  final Set<Polyline>? polylines;

}

class RunResultError extends RunResultState {}
