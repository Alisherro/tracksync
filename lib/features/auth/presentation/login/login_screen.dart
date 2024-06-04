import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/utils/utils.dart';

import '../../../../core/core.dart';
import '../../domain/entities/login.dart';
import '../profile/bloc/user_bloc.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: BlocListener<LoginCubit, LoginState>(
        listener: (_, state) {
          switch (state) {
            case LoginLoading():
              context.show();
              break;
            case LoginSuccess():
              context.dismiss();
              context.read<UserBloc>().add(UserLoggedIn(
                  user: state.login!.user, token: state.login!.token));
              break;
            case LoginFailure():
              context.dismiss();
              state.message.toToastError(context);
              // context.go('/run');
              break;
            case LoginState():
              null;
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: AutofillGroup(
                child: Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SpacerV(),
                      TextF(
                        autofillHints: const [AutofillHints.email],
                        key: const Key("email"),
                        curFocusNode: _fnEmail,
                        nextFocusNode: _fnPassword,
                        textInputAction: TextInputAction.next,
                        controller: _conEmail,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: SvgPicture.asset(
                          Images.mail,
                        ),
                        hintText: "example@email.com",
                        hint: Strings.of(context)!.email,
                        validator: (String? value) => value != null
                            ? (!value.isValidEmail()
                                ? Strings.of(context)?.errorInvalidEmail
                                : null)
                            : null,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (_, state) {
                          return TextF(
                            autofillHints: const [AutofillHints.password],
                            key: const Key("password"),
                            curFocusNode: _fnPassword,
                            textInputAction: TextInputAction.done,
                            controller: _conPassword,
                            keyboardType: TextInputType.text,
                            prefixIcon: SvgPicture.asset(Images.lockon),
                            obscureText:
                                context.read<LoginCubit>().isPasswordHide ??
                                    false,
                            hintText: 'Your password',
                            maxLine: 1,
                            hint: Strings.of(context)!.password,
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  context.read<LoginCubit>().showHidePassword(),
                              child:
                                  (context.read<LoginCubit>().isPasswordHide ??
                                          false)
                                      ? SvgPicture.asset(Images.eyeclosed)
                                      : const Icon(Icons.visibility),
                            ),
                            validator: (String? value) => value != null
                                ? (value.length < 6
                                    ? Strings.of(context)!.errorPasswordLength
                                    : null)
                                : null,
                          );
                        },
                      ),
                      SpacerV(value: Dimens.space24),
                      Button(
                        title: Strings.of(context)!.login,
                        onPressed: () {
                          if (_keyForm.currentState?.validate() ?? false) {
                            context.read<LoginCubit>().login(
                                  LoginParams(
                                    email: _conEmail.text,
                                    password: _conPassword.text,
                                  ),
                                );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?  ',
                            style: TextStyle(color: Palette.greyColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push('/registration');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Palette.secondColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
