part of 'user_bloc.dart';

@immutable
sealed class UserState extends Equatable {}

final class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserAuthenticated extends UserState {
  UserAuthenticated({required this.user,required this.token});

  final User user;
  final String token;

  @override
  List<Object?> get props => [user,token];

  UserAuthenticated copyWith({
    User? user,
    String? token,
  }) {
    return UserAuthenticated(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }
}

final class UserUnauthenticated extends UserState {
  @override
  List<Object?> get props => [];
}
