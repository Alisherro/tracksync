import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/user_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.userUseCase) : super(LoginInitial());

  final UserUseCase userUseCase;

  Future<void> onLoginButtonTapped(
      String userName, String password, bool remember) async {
    emit(LoginLoading());
    try {
      String token = await userUseCase.login(userName, password);
      print(token);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError());
    }
    emit(LoginInitial());
  }
}
