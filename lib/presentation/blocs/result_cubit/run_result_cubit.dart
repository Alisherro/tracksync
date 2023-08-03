import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smerse/data/models/run_result.dart';
import 'package:smerse/domain/use_cases/run_result_use_case.dart';

part 'run_result_state.dart';

class RunResultCubit extends Cubit<RunResultState> {
  RunResultCubit(this.useCase, this.resultID) : super(RunResultInitial());
  final String resultID;
  final RunResultUseCase useCase;

  Future<void> initState() async {
    final RunResult? result = await useCase.getRunResultById(resultID);
    if (result == null) {
      emit(RunResultError());
    } else {
      emit(RunResultSuccess(result));
    }
  }
}
