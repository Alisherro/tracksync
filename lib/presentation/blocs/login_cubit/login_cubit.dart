import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/data/models/user.dart';

import '../../../domain/use_cases/user_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(UserUseCase userUseCase) : _userUseCase=userUseCase, super(LoginInitial());

  final UserUseCase _userUseCase;

  Future<void> onLoginButtonTapped(
      String userName, String password, bool remember) async {
    emit(LoginLoading());
    try {
      String token = await _userUseCase.login(userName, password);
      emit(LoginSuccess(User(nickName: userName)));
    } catch (e) {
      emit(LoginError());
    }
    emit(LoginInitial());
  }
}
