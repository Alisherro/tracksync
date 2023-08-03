import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smerse/presentation/screens/choose_level_screen.dart';
import 'package:smerse/presentation/screens/choose_split_screen.dart';

import '../blocs/user_config_bloc/user_config_bloc.dart';
import 'choose_details_screen.dart';
import 'choose_gender_screen.dart';
import 'choose_goals_screen.dart';

class ConfigurationPagesScreen extends StatelessWidget {
  const ConfigurationPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<UserConfigBloc>().pageController,
        children: const [
          ChooseGenderScreen(),
          ChooseGoalsScreen(),
          ChooseLevelScreen(),
          ChooseSplitScreen(),
          ChooseDetailsScreen(),
        ],
      ),
    );
  }
}
