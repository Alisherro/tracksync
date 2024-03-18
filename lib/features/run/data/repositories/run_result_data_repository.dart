import 'package:flutter/material.dart';

import '../../domain/entities/run_result.dart';
import '../../domain/repositories/run_result_repository.dart';
import '../datasources/run_result_local_datasource.dart';

class RunResultRepositoryImpl implements RunResultRepository {
  RunResultRepositoryImpl(this.resultDataProvider);

  final RunResultDatasource resultDataProvider;

  @override
  Future<List<RunResult>> getAllResults([DateTimeRange? range]) async {
    return await resultDataProvider.getRunResultsList(range);
  }

  @override
  Future<RunResult?> getRunResultById(String id) async {
    return await resultDataProvider.getRunResultById(id);
  }

  @override
  Future<int?> saveRunResult(RunResult runResult) async {
    return await resultDataProvider.saveRunResult(runResult);
  }
}
