import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracksync/features/auth/presentation/configuration/widgets/details_choose.dart';
import 'package:tracksync/features/auth/presentation/configuration/widgets/gender_choose.dart';
import 'package:tracksync/features/auth/presentation/configuration/widgets/goals_choose.dart';
import 'package:tracksync/features/auth/presentation/configuration/widgets/level_choose.dart';
import 'package:tracksync/utils/ext/ext.dart';

import '../profile/bloc/user_bloc.dart';
import 'bloc/user_config_bloc.dart';

class ConfigurationPagesScreen extends StatelessWidget {
  const ConfigurationPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserConfigBloc, UserConfigState>(
        listener: (context, state) {
          if (state is UserConfigStateLoading) {
            context.show();
          } else if (state is UserConfigStateFailed) {
            context.dismiss();
            state.message.toToastError(context);
          } else if (state is UserConfigStateSuccess) {
            context.dismiss();
            context.read<UserBloc>().add(UserUpdateInformation(state.user));
          }
        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: context.read<UserConfigBloc>().pageController,
          children: const [
            ChooseGenderScreen(),
            ChooseGoalsScreen(),
            ChooseLevelScreen(),
            ChooseDetailsScreen(),
          ],
        ),
      ),
    );
  }
}
