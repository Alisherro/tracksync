part of 'register_cubit.dart';

sealed class RegisterState {
  const RegisterState();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final Register? data;

  const RegisterSuccess(this.data);
}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure(this.message);
}

class RegisterInit extends RegisterState {
  const RegisterInit();
}

class ShowHidePassword extends RegisterState {
  const ShowHidePassword();
}
