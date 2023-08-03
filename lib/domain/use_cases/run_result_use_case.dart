import 'package:flutter/material.dart';

import '../../data/models/run_result.dart';
import '../repositories/run_result_repository.dart';

class RunResultUseCase {
  RunResultUseCase(this.repository);

  final RunResultRepository repository;

  Future<int?> saveResult(RunResult result) async {
    return await repository.saveRunResult(result);
  }

  Future<RunResult?> getRunResultById(String id) async {
    return await repository.getRunResultById(id);
  }

  Future<List<RunResult>> getAllResults([DateTimeRange? range]) async {
    return await repository.getAllResults(range);
  }
}
