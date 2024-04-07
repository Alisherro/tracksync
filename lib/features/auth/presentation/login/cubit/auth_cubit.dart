import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/error.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(const AuthLoading());

  final AuthRepository _repo;

  bool? isPasswordHide = true;

  void showHidePassword() {
    emit(const AuthInit());
    isPasswordHide = !(isPasswordHide ?? false);
    emit(const AuthShowHide());
  }

  Future<void> login(LoginParams params) async {
    emit(const AuthLoading());
    final data = await _repo.login(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(AuthFailure(l.message ?? ""));
        }
      },
      (r) => emit(AuthSuccess(Login(r.token, r.user))),
    );
  }

}
