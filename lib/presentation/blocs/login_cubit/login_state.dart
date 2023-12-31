part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  LoginError({this.errorDescription});

  final String? errorDescription;
}

class LoginSuccess extends LoginState {
  LoginSuccess(this.user);

  final User user;
}
