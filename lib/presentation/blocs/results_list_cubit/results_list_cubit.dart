import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smerse/domain/use_cases/run_result_use_case.dart';

import '../../../data/models/run_result.dart';

part 'results_list_state.dart';

class ResultsListCubit extends Cubit<ResultsListState> {
  ResultsListCubit(this.useCase) : super(ResultsListInitial());
  final RunResultUseCase useCase;

  Future<void> initState([DateTimeRange? range]) async {
    final DateTime now = DateTime.now();
    final List<RunResult> results = await useCase.getAllResults(
      range ??
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
          dateRange: range?.start ?? DateTime.now()),
    );
  }

  void dateTimeChange(DateTime dateTimeStart) {
    final DateTime dateTimeEnd =
        DateTime(dateTimeStart.year, dateTimeStart.month + 1, 1);
    initState(DateTimeRange(start: dateTimeStart, end: dateTimeEnd));
  }
}
