part of 'run_result_cubit.dart';

@immutable
abstract class RunResultState {}

class RunResultInitial extends RunResultState {}

class RunResultSuccess extends RunResultState {
  RunResultSuccess(this.result);

  final RunResult result;
}

class RunResultError extends RunResultState {}
