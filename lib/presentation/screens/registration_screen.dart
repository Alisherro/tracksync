import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:tracksync/presentation/providers/user_provider.dart';
import '../../constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool remember = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorDescription ?? 'Error'),
            ),
          );
        } else if (state is RegisterSuccess) {
          context.read<UserProvider>().user = state.user;
          context.go('/run');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Register', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(
                'Create your new account',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(disabledButtonColor)),
                        onPressed: () {},
                        child: const Text('Login'),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<RegisterCubit>().onLoginButtonTapped(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              remember);
                        },
                        child: const Text('Login'),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: remember,
                          onChanged: (val) {
                            setState(() {
                              remember = val ?? false;
                            });
                          }),
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
              const SizedBox(height: 30),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('Or continue with'),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                              backgroundColor:
                                  const MaterialStatePropertyAll(pinkColor)),
                      onPressed: () {},
                      child: const Text('Google'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                            backgroundColor:
                                const MaterialStatePropertyAll(blueColor),
                            padding:
                                const MaterialStatePropertyAll(EdgeInsets.zero),
                          ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/apple_logo.svg'),
                          const SizedBox(width: 12),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text('Apple'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?  ',
                    style: TextStyle(color: greyColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: secondColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
