part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess(this.data);

  final String? data;
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;
}

class AuthShowHide extends AuthState {
  const AuthShowHide();
}

class AuthInit extends AuthState {
  const AuthInit();
}
