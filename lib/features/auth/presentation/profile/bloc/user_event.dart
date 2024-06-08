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

class UserLogout extends UserEvent {
  const UserLogout();
}

class UserDelete extends UserEvent {
  const UserDelete();
}

class UserChangeProfilePicture extends UserEvent {
  const UserChangeProfilePicture();
}

class UserUpdateInformation extends UserEvent{
  const UserUpdateInformation(this.user);
  final User user;
}