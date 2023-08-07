import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/presentation/blocs/login_cubit/login_cubit.dart';

import '../../constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go('/run');
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error'),
              duration: Duration(milliseconds: 300),
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login to your account',
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (val) {},
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Remember Me',
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                    Text(
                      'Forgot Password ?',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else {
                            return ElevatedButton(
                              onPressed: () {
                                context.read<LoginCubit>().onLoginButtonTapped(
                                    userNameController.text,
                                    passwordController.text,
                                    true);
                              },
                              child: const Text('Login'),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?  ',
                          style: TextStyle(color: greyColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go('/registration');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: secondColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
