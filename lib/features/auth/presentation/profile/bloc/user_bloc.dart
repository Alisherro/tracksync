import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracksync/core/core.dart';
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
          case UserLogout():
            await onUserLogOut(emit);
          case UserChangeProfilePicture():
            await onUserChangeProfilePicture(emit);
          case UserUpdateInformation():
            await onUserUpdateInformation(event, emit);
          case UserDelete():
            await onUserDelete(event, emit);
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
      emitter(UserAuthenticated(user: user!));
      final resNewUser = await userRepository.getRemoteUser();
      if (state is UserAuthenticated) {
        resNewUser.fold((l) {
          if (l is UnauthenticatedFailure) {
            add(const UserLogout());
          }
        }, (r) {
          userRepository.saveUser(r);
          emitter(UserAuthenticated(user: r));
        });
      }
    } else {
      add(const UserLogout());
    }
  }

  Future<void> onUserLoggedIn(UserLoggedIn event, Emitter emitter) async {
    final userRes = await userRepository.saveUser(event.user);
    final tokenRes = await userRepository.saveUserToken(event.token);
    userRes.fold((l) => null, (r) => null);
    tokenRes.fold((l) => null, (r) => null);

    emitter(UserAuthenticated(user: event.user));
  }

  Future<void> onUserLogOut(Emitter emitter) async {
    userRepository.logout();
    emitter(UserUnauthenticated());
  }

  Future<void> onUserDelete(UserDelete event, Emitter emitter) async {
    emitter(SLoading());
    final response = await userRepository.delete();
    response.fold(
      (l) {
        emitter(SFailed(l.message ?? 'Unexpected error'));
      },
      (r) {
        emitter(UserUnauthenticated());
        emitter(SSuccess(r??'Account deleted successfully'));
      },
    );
  }

  Future<void> onUserChangeProfilePicture(Emitter emitter) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emitter(SLoading());
      String fileName = image.path.split('/').last;
      final res =
          await userRepository.changeProfilePicture(image.path, fileName);
      res.fold((l) {
        emitter(SFailed(l.message ?? 'error'));
      }, (r) {
        emitter(SSuccess("Profile picture successfully changed"));
        if (r != null) {
          emitter(UserAuthenticated(user: r));
        }
      });
    }
  }

  Future<void> onUserUpdateInformation(
      UserUpdateInformation event, Emitter emitter) async {
    userRepository.saveUser(event.user);
    emitter(UserAuthenticated(user: event.user));
  }
}
