import 'package:flutter/material.dart';

import '../entities/run_result.dart';

abstract interface class RunResultRepository {
  Future<RunResult?> getRunResultById(String id);

  Future<int?> saveRunResult(RunResult runResult);

  Future<List<RunResult>> getAllResults([DateTimeRange? range]);

  Future<void> clear();
}
