import 'package:dartz/dartz.dart';
import 'package:tracksync/core/core.dart';
import 'package:tracksync/features/run/domain/entities/run_result.dart';

import '../models/run_result_response.dart';

abstract interface class RunResultRemoteDatasource {
  Future<Either<Failure, void>> saveRunResult(RunResult data);

  Future<Either<Failure, List<RunResultResponse>>> getRunResults();
}

class RunResultRemoteDatasourceImpl implements RunResultRemoteDatasource {
  RunResultRemoteDatasourceImpl(this.dioClient);

  DioClient dioClient;

  @override
  Future<Either<Failure, void>> saveRunResult(RunResult data) async {
    return dioClient.postRequest<void>(
      ListAPI.runSession,
      converter: (_) {},
      data: data.toMap(),
    );
  }

  @override
  Future<Either<Failure, List<RunResultResponse>>> getRunResults() async {
    return await dioClient.getRequest<List<RunResultResponse>>(
      ListAPI.runSession,
      converter: (response) {
        List<dynamic> data = (response as Map<String, dynamic>)['data'] as List;
        List<RunResultResponse> list =
            data.map((e) => RunResultResponse.fromJson(e)).toList();
        return list;
      },
    );
  }
}
