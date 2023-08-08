part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess(this.user);

  final User user;
}

class RegisterFail extends RegisterState {}

class RegisterLoading extends RegisterState {}
