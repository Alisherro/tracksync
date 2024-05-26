import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/run_result.dart';

abstract class RunResultLocalDatasource {
  Future<RunResult?> getRunResultById(String id);

  Future<int?> saveRunResult(RunResult runResult);

  Future<List<RunResult>> getRunResultsList([DateTimeRange? range]);
}

class RunResultDatasourceIsar extends RunResultLocalDatasource {
  final Isar isar;

  RunResultDatasourceIsar(this.isar);

  @override
  Future<RunResult?> getRunResultById(String id) async {
    return isar.runResults.get(int.parse(id));
  }

  @override
  Future<int?> saveRunResult(RunResult runResult) async {
    int? id;
    isar.writeTxnSync(() {
      id = isar.runResults.putSync(runResult);
    });
    return id;
  }

  @override
  Future<List<RunResult>> getRunResultsList([DateTimeRange? range]) async {
    if (range == null) {
      return isar.runResults.where().sortByDateTimeDesc().findAll();
    } else {
      return isar.runResults
          .where()
          .filter()
          .dateTimeBetween(range.start, range.end)
          .sortByDateTimeDesc()
          .findAll();
    }
  }
}
