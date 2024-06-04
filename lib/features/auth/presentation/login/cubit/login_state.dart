part of 'login_cubit.dart';

sealed class LoginState {
  const LoginState();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.login);

  final Login? login;
}

class LoginFailure extends LoginState {
  const LoginFailure(this.message);

  final String message;
}

class LoginShowHide extends LoginState {
  const LoginShowHide();
}

class LoginInit extends LoginState {
  const LoginInit();
}
