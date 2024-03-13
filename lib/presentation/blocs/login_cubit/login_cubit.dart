import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../dependencies_injection.dart';
import 'package:tracksync/data/models/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()   :super(LoginInitial());

  UserRepository get _repo => locator<UserRepository>();

  Future<void> onLoginButtonTapped(
      String userName, String password, bool remember) async {
    if (userName.length > 1 && password.length > 1) {
      emit(LoginLoading());
      try {
        String token = await _repo.login(userName, password);
        print(token);
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
