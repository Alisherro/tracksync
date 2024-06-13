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
    List<RunResult> list = await local.getRunResultsList(range);
    if (list.isEmpty) {
      final response = await remote.getRunResults();
      return response.fold(
        (l) async {
          return [];
        },
        (r) {
          final List<RunResult> list = r
              .map((e) => e.toEntity())
              .where((element) => element != null)
              .cast<RunResult>()
              .toList();

          local.saveRunResultList(list);
          return list;
        },
      );
    }else{
      return list;
    }
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

  @override
  Future<void> clear() async {
    await local.clear();
  }
}
