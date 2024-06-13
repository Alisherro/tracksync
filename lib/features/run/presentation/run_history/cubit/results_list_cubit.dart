import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/run_result.dart';
import '../../../domain/repositories/run_result_repository.dart';

part 'results_list_state.dart';

class ResultsListCubit extends Cubit<ResultsListState> {
  ResultsListCubit(this._repo) : super(ResultsListInitial());

  final RunResultRepository _repo;

  DateTimeRange? currentDateTimeRange;

  Future<void> initState([DateTimeRange? range]) async {
    if (range != null) {
      currentDateTimeRange = range;
    }
    final DateTime now = DateTime.now();
    final List<RunResult> results = await _repo.getAllResults(
      currentDateTimeRange ??
          DateTimeRange(
            start: DateTime(now.year, now.month, 0),
            end: DateTime(now.year, now.month + 1, 1),
          ),
    );
    final totalKm =
        results.fold<double>(0, (sum, value) => sum + (value.distance ?? 0));
    final totalSeconds =
        results.fold(0, (sum, value) => sum + (value.totalSeconds ?? 0));
    final totalCalories =
        results.fold(0.0, (sum, value) => sum + (value.kcal ?? 0));
    final totalWorkouts = results.length;
    emit(
      ResultsListSuccess(
        totalKm: totalKm,
        totalDuration: Duration(seconds: totalSeconds),
        totalCalories: totalCalories.toInt(),
        totalWorkouts: totalWorkouts,
        results: results,
        dateRange: currentDateTimeRange?.start ?? DateTime.now(),
      ),
    );
  }

  void dateTimeChange(DateTime dateTimeStart) {
    final DateTime dateTimeEnd =
        DateTime(dateTimeStart.year, dateTimeStart.month + 1, 1);
    initState(DateTimeRange(start: dateTimeStart, end: dateTimeEnd));
  }

  Future<int> saveRunResult(RunResult data) async {
    int? id = await _repo.saveRunResult(data);
    initState();
    return id ?? 0;
  }
}
