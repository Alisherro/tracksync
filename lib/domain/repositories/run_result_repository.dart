import 'package:flutter/material.dart';

import '../../data/data_provider/run_result_data_provider.dart';
import '../../data/models/run_result.dart';

abstract interface class RunResultRepository {
  Future<RunResult?> getRunResultById(String id);

  Future<int?> saveRunResult(RunResult runResult);

  Future<List<RunResult>> getAllResults([DateTimeRange? range]);
}
