import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/domain/repositories/user_repository.dart';

import '../../../dependencies_injection.dart';

import '../../../data/models/user.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  UserRepository get _repo => locator.get<UserRepository>();

  Future<void> onLoginButtonTapped(
      String userName, String email, String password, bool remember) async {
    emit(RegisterLoading());
    try {
      bool success = await _repo.register(userName, email, password);
      success
          ? emit(RegisterSuccess(User(nickName: userName)))
          : emit(RegisterFail());
    } catch (e) {
      emit(RegisterFail(errorDescription: e.toString()));
    }
  }
}
