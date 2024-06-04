part of 'user_bloc.dart';

@immutable
sealed class UserState   {}

final class UserLoading extends UserState {

}

final class UserAuthenticated extends UserState {
  UserAuthenticated({required this.user});

  final User user;
}

final class UserUnauthenticated extends UserState {
}

final class SLoading extends UserState{
  SLoading();
}

final class SFailed extends UserState{
  SFailed(this.error);
  final String? error;
}

final class SSuccess extends UserState{
  SSuccess(this.message);
  final String? message;
}
