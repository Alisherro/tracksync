import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserLoading()) {
    on<UserEvent>(
      (event, emit) async {
        switch (event) {
          case UserFetch():
            await fetchUserData(emit);
          case UserLoggedIn():
            await onUserLoggedIn(event, emit);
          case UserLogOut():
            await onUserLogOut(emit);
        }
      },
    );
  }

  Future<void> fetchUserData(Emitter emitter) async {
    final resUser = await userRepository.getSavedUser();
    final resToken = await userRepository.getSavedToken();
    User? user;
    String? token;
    resUser.fold((l) {}, (r) => user = r);
    resToken.fold((l) {}, (r) => token = r);

    if (user != null && token != null) {
      emitter(UserAuthenticated(user: user!, token: token!));
      final resNewUser = await userRepository.getRemoteUser();
      if (state is UserAuthenticated) {
        resNewUser.fold((l) => null,
            (r) => emitter((state as UserAuthenticated)..copyWith(user: r)));
      }
    } else {
      emitter(UserUnauthenticated());
    }
  }

  Future<void> onUserLoggedIn(UserLoggedIn event, Emitter emitter) async {
    final userRes = await userRepository.saveUser(event.user);
    final tokenRes = await userRepository.saveUserToken(event.token);
    userRes.fold((l) => null, (r) => null);
    tokenRes.fold((l) => null, (r) => null);

    emitter(UserAuthenticated(user: event.user, token: event.token));
  }

  Future<void> onUserLogOut(Emitter emitter) async {
    userRepository.logout();
    emitter(UserUnauthenticated());
  }
}
