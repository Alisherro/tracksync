import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/utils/utils.dart';
import '../../../../core/core.dart';
import '../../domain/entities/login.dart';
import 'cubit/cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (_, state) {
          switch (state) {
            case AuthLoading():
              context.show();
              break;
            case AuthSuccess():
              context.dismiss();
              state.data.toString().toToastSuccess(context);
              context.go('/run');
              break;
            case AuthFailure():
              context.dismiss();
              state.message.toToastError(context);
              context.go('/run');

              break;
            case AuthState():
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
                      BlocBuilder<AuthCubit, AuthState>(
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
                                context.read<AuthCubit>().isPasswordHide ??
                                    false,
                            hintText: 'Your password',
                            maxLine: 1,
                            hint: Strings.of(context)!.password,
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  context.read<AuthCubit>().showHidePassword(),
                              child:
                                  (context.read<AuthCubit>().isPasswordHide ??
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
                            context.read<AuthCubit>().login(
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
