import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/data/models/run_result.dart';

import '../../../dependencies_injection.dart';
import '../../../domain/repositories/run_result_repository.dart';

part 'run_result_state.dart';

class RunResultCubit extends Cubit<RunResultState> {
  RunResultCubit(this.resultID) : super(RunResultInitial());
  final String resultID;

  RunResultRepository get _repo => locator<RunResultRepository>();

  Future<void> initState() async {
    final RunResult? result = await _repo.getRunResultById(resultID);
    if (result == null) {
      emit(RunResultError());
    } else {
      emit(RunResultSuccess(result));
    }
  }
}
