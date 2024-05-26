import 'package:dartz/dartz.dart';
import 'package:tracksync/core/core.dart';
import 'package:tracksync/features/run/domain/entities/run_result.dart';

abstract interface class RunResultRemoteDatasource {
  Future<Either<Failure,void>> saveRunResult(RunResult data);
}

class RunResultRemoteDatasourceImpl implements RunResultRemoteDatasource {
  RunResultRemoteDatasourceImpl(this.dioClient);

  DioClient dioClient;

  @override
  Future<Either<Failure,void>> saveRunResult(RunResult data) async {
    return dioClient.postRequest<void>(
      ListAPI.storeSession,
      converter: (_) {},
      data: data.toMap(),
    );
  }
}
