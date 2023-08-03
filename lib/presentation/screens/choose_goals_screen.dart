import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smerse/constants.dart';
import 'package:smerse/presentation/widgets/config_title_widget.dart';
import 'package:smerse/presentation/widgets/next_button_widget.dart';

import '../blocs/user_config_bloc/user_config_bloc.dart';
import '../widgets/option_radio_button_widget.dart';

class ChooseGoalsScreen extends StatelessWidget {
  const ChooseGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context
        .select((UserConfigBloc bloc) => bloc.state.selectedGoalsIndexes);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const ConfigTitleWidget(
            title: 'What are your top 3 goals?',
            subtitle:
                'Rank your goals so your Coach can help you achieve them.',
          ),
          const SizedBox(height: 30),
          Column(
            children: List.generate(
              goals.length,
              (index) => OptionRadioButtonWidget(
                onTap: () {
                  context
                      .read<UserConfigBloc>()
                      .add(GoalButtonTapped(index: index));
                },
                isSelected: list.contains(index),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(goals[index]),
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: NextButtonWidget(
              isEnable: list.length == 3,
              enableCallback: () {
                context.read<UserConfigBloc>().add(NextButtonTapEvent());
              },
              disableCallback: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: snackBarDuration,
                    content: Text('You must choose 3 goals'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
