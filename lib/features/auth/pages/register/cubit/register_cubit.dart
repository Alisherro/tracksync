import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracksync/features/auth/auth.dart';
import '../../../../../core/error/failure.dart';

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
        if (l is ServerFailure) {
          emit(RegisterFailure(l.message ?? ""));
        }
      },
      (r) => emit(RegisterSuccess(r)),
    );
  }
}
