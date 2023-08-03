import 'package:flutter/src/material/date.dart';

import 'package:tracksync/data/models/run_result.dart';

import '../../domain/repositories/run_result_repository.dart';
import '../data_provider/run_result_data_provider.dart';

class RunResultDataRepository extends RunResultRepository {
  RunResultDataRepository(this.resultDataProvider);

  final RunResultDataProvider resultDataProvider;

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
