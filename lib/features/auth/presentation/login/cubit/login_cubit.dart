import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/error.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repo) : super(const LoginLoading());

  final AuthRepository _repo;

  bool? isPasswordHide = true;

  void showHidePassword() {
    emit(const LoginInit());
    isPasswordHide = !(isPasswordHide ?? false);
    emit(const LoginShowHide());
  }

  Future<void> login(LoginParams params) async {
    emit(const LoginLoading());
    final data = await _repo.login(params);

    data.fold(
      (l) {
          emit(LoginFailure(l.message ?? ""));
      },
      (r) => emit(LoginSuccess(Login(r.token, r.user))),
    );
  }

}
