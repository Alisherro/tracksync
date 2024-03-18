import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracksync/features/auth/auth.dart';
import '../../../../../core/error/error.dart';

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
      (r) => emit(AuthSuccess(r.token)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    isPasswordHide = true;
    // await MainBoxMixin().logoutBox();
    emit(const AuthSuccess(null));
  }
}
