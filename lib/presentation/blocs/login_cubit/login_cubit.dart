import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/data/models/user.dart';

import '../../../domain/use_cases/user_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(UserUseCase userUseCase)
      : _userUseCase = userUseCase,
        super(LoginInitial());

  final UserUseCase _userUseCase;

  Future<void> onLoginButtonTapped(
      String userName, String password, bool remember) async {
    if (userName.length > 1 && password.length > 1) {
      emit(LoginLoading());
      try {
        String token = await _userUseCase.login(userName, password);
        emit(LoginSuccess(User(nickName: userName)));
      } catch (e) {
        emit(LoginError(errorDescription: e.toString()));
      }
      emit(LoginInitial());
    } else {
      emit(LoginError(
          errorDescription: 'too short length of email or password'));
    }
  }
}
