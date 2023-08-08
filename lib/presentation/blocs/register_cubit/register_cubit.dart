import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user.dart';
import '../../../domain/use_cases/user_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(UserUseCase userUseCase)
      : _userUseCase = userUseCase,
        super(RegisterInitial());
  final UserUseCase _userUseCase;

  Future<void> onLoginButtonTapped(
      String userName, String email, String password, bool remember) async {
    emit(RegisterLoading());
    try {
      bool success = await _userUseCase.register(userName, email, password);
      success
          ? emit(RegisterSuccess(User(nickName: userName)))
          : emit(RegisterFail());
    } catch (e) {
      emit(RegisterFail(errorDescription: e.toString()));
    }
  }
}
