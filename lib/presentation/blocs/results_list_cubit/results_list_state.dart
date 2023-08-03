part of 'results_list_cubit.dart';

@immutable
abstract class ResultsListState {}

class ResultsListInitial extends ResultsListState {}

class ResultsListSuccess extends ResultsListState {
  ResultsListSuccess({
    required this.totalKm,
    required this.totalDuration,
    required this.totalCalories,
    required this.totalWorkouts,
    required this.results,
    required this.dateRange,
  });

  final List<RunResult> results;
  final double totalKm;
  final Duration totalDuration;
  final int totalCalories;
  final int totalWorkouts;
  final DateTime dateRange;
}
