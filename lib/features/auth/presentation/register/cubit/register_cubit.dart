import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/register.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository repo;

  bool? isPasswordHide = true;
  bool? isPasswordRepeatHide = true;

  RegisterCubit(this.repo) : super(const RegisterLoading());

  void showHidePassword() {
    emit(const RegisterInit());
    isPasswordHide = !(isPasswordHide ?? false);
    emit(const ShowHidePassword());
  }

  void showHidePasswordRepeat() {
    emit(const RegisterInit());
    isPasswordRepeatHide = !(isPasswordRepeatHide ?? false);
    emit(const ShowHidePassword());
  }

  Future<void> register(RegisterParams params) async {
    emit(const RegisterLoading());
    final data = await repo.register(params);
    data.fold(
      (l) {
          emit(RegisterFailure(l.message ?? ""));
      },
      (r) => emit(RegisterSuccess(r)),
    );
  }
}
