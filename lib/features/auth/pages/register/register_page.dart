import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/utils/utils.dart';
import '../../../../core/localization/generated/strings.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/register.dart';
import 'cubit/cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conPasswordRepeat = TextEditingController();

  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();
  final _fnPasswordRepeat = FocusNode();

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: const MyAppBar().call(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (_, state) {
          switch (state) {
            case RegisterLoading():
              context.show();
              break;
            case RegisterSuccess():
              context.dismiss();
              context.pop();
              break;
            case RegisterFailure():
              context.dismiss();
              state.message.toToastError(context);
              break;
            case RegisterState():
              null;
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: Form(
                key: _keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Create new account',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SpacerV(),
                    TextF(
                      key: const Key("email"),
                      curFocusNode: _fnEmail,
                      nextFocusNode: _fnPassword,
                      textInputAction: TextInputAction.next,
                      controller: _conEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: SvgPicture.asset(
                        Images.mail,
                      ),
                      hintText: 'example@email.com',
                      hint: Strings.of(context)!.email,
                      validator: (String? value) => value != null
                          ? (!value.isValidEmail()
                              ? Strings.of(context)?.errorInvalidEmail
                              : null)
                          : null,
                    ),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (_, state) {
                        return Column(
                          children: [
                            TextF(
                              key: const Key("password"),
                              curFocusNode: _fnPassword,
                              nextFocusNode: _fnPasswordRepeat,
                              textInputAction: TextInputAction.next,
                              controller: _conPassword,
                              keyboardType: TextInputType.text,
                              prefixIcon: SvgPicture.asset(Images.lockon),
                              obscureText: context
                                      .read<RegisterCubit>()
                                      .isPasswordHide ??
                                  false,
                              hintText: 'Your password',
                              maxLine: 1,
                              hint: Strings.of(context)!.password,
                              suffixIcon: GestureDetector(
                                onTap: () => context
                                    .read<RegisterCubit>()
                                    .showHidePassword(),
                                child: context
                                            .read<RegisterCubit>()
                                            .isPasswordHide ??
                                        false
                                    ? SvgPicture.asset(Images.eyeclosed)
                                    : const Icon(Icons.visibility),
                              ),
                              validator: (String? value) => value != null
                                  ? (value.length < 6
                                      ? Strings.of(context)!.errorPasswordLength
                                      : null)
                                  : null,
                            ),
                            TextF(
                              key: const Key("repeat_password"),
                              curFocusNode: _fnPasswordRepeat,
                              textInputAction: TextInputAction.done,
                              controller: _conPasswordRepeat,
                              keyboardType: TextInputType.text,
                              prefixIcon: SvgPicture.asset(Images.lockon),
                              obscureText: context
                                      .read<RegisterCubit>()
                                      .isPasswordRepeatHide ??
                                  false,
                              hintText: 'Confirm password',
                              maxLine: 1,
                              hint: Strings.of(context)!.passwordRepeat,
                              suffixIcon: GestureDetector(
                                onTap: () => context
                                    .read<RegisterCubit>()
                                    .showHidePasswordRepeat(),
                                child: context
                                            .read<RegisterCubit>()
                                            .isPasswordRepeatHide ??
                                        false
                                    ? SvgPicture.asset(Images.eyeclosed)
                                    : const Icon(Icons.visibility),
                              ),
                              validator: (String? value) => value != null
                                  ? (value != _conPassword.text
                                      ? Strings.of(context)
                                          ?.errorPasswordNotMatch
                                      : null)
                                  : null,
                            ),
                          ],
                        );
                      },
                    ),
                    SpacerV(value: Dimens.space24),
                    Button(
                      key: const Key("btn_register"),
                      title: Strings.of(context)!.register,
                      onPressed: () {
                        if (_keyForm.currentState?.validate() ?? false) {
                          context.read<RegisterCubit>().register(
                                RegisterParams(
                                  email: _conEmail.text,
                                  password: _conPassword.text,
                                ),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
