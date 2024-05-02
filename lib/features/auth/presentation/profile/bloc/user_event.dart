part of 'user_bloc.dart';

@immutable
sealed class UserEvent {
  const UserEvent();
}

class UserFetch extends UserEvent {
  const UserFetch();
}

class UserLoggedIn extends UserEvent {
  const UserLoggedIn({required this.user, required this.token});
  final String token;
  final User user;
}

class UserLogOut extends UserEvent{
  const UserLogOut();
}
