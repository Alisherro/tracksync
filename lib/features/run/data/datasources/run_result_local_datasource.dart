import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/run_result.dart';

abstract class RunResultDatasource {
  Future<RunResult?> getRunResultById(String id);

  Future<int?> saveRunResult(RunResult runResult);

  Future<List<RunResult>> getRunResultsList([DateTimeRange? range]);
}

class RunResultDatasourceIsar extends RunResultDatasource {
  late Future<Isar> db;

  RunResultDatasourceIsar() {
    db = _openDB();
  }

  Future<Isar> _openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([RunResultSchema], directory: dir.path);
    }
    return await Future.value(Isar.getInstance());
  }

  @override
  Future<RunResult?> getRunResultById(String id) async {
    final isar = await db;
    return isar.runResults.get(int.parse(id));
  }

  @override
  Future<int?> saveRunResult(RunResult runResult) async {
    final isar = await db;
    int? id;
    isar.writeTxnSync(() {
      id = isar.runResults.putSync(runResult);
    });
    return id;
  }

  @override
  Future<List<RunResult>> getRunResultsList([DateTimeRange? range]) async {
    final isar = await db;
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
