import 'package:flutter/material.dart';
import 'package:tracksync/features/run/data/datasources/run_result_remote_datasource.dart';

import '../../domain/entities/run_result.dart';
import '../../domain/repositories/run_result_repository.dart';
import '../datasources/run_result_local_datasource.dart';

class RunResultRepositoryImpl implements RunResultRepository {
  RunResultRepositoryImpl(this.local, this.remote);

  final RunResultLocalDatasource local;
  final RunResultRemoteDatasource remote;

  @override
  Future<List<RunResult>> getAllResults([DateTimeRange? range]) async {
    return await local.getRunResultsList(range);
  }

  @override
  Future<RunResult?> getRunResultById(String id) async {
    return await local.getRunResultById(id);
  }

  @override
  Future<int?> saveRunResult(RunResult runResult) async {
    int? id = await local.saveRunResult(runResult);
    await remote.saveRunResult(runResult);
    return id;
  }
}
