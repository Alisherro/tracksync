import 'package:tracksync/core/api/api.dart';
import 'package:tracksync/features/run/domain/entities/run_result.dart';

abstract interface class RunResultRemoteDatasource{
  Future<void> saveRunResult(RunResult data);
}

class RunResultRemoteDatasourceImpl implements RunResultRemoteDatasource{
  RunResultRemoteDatasourceImpl(this.dioClient);
  DioClient dioClient;

  @override
  Future<void> saveRunResult(RunResult data) async {
    try{
      dioClient.postRequest(ListAPI.storeSession, converter: (_){}, data: data.toMap());
    } catch (e){
      print('oopsipoopsie');
    }
  }

}