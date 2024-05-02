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
        switch (state){
          case UserLoading():print('loading');
          case UserAuthenticated():context.go('/run');
          case UserUnauthenticated():context.go('/login');
        }
      },
      child:const Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(color: Colors.green),
          child: Center(
            child: Text('Splash Screen'),
          ),
        ),
      ),
    );
  }
}
