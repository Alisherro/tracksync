import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracksync/core/core.dart';
import '../bloc/user_config_bloc.dart';
import 'config_title_widget.dart';
import 'option_radio_button_widget.dart';

class ChooseGoalsScreen extends StatelessWidget {
  const ChooseGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context
        .select((UserConfigBloc bloc) => (bloc.state as UserConfigStateData).selectedGoalsIndexes);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const ConfigTitleWidget(
            title: 'What are your main running goals?',
            subtitle:
                'It will help us ',
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
                  child: Text(
                    goals[index],
                    style: const TextStyle(color: Palette.background),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Button(
              title: 'Next',
              onPressed: () {
                if (list.length == 3) {
                  context.read<UserConfigBloc>().add(NextButtonTapEvent());
                }
              },
              color: list.length == 3 ? null : Palette.emptyColor,
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
