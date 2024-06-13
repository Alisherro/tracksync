import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../profile/bloc/user_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserLoading():
          case UserAuthenticated():
            context.go('/run');
          case UserUnauthenticated():
            context.go('/login');
          case SLoading():
          case SFailed():
          case SSuccess():
        }
      },
      child: const Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
