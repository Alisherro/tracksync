import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smerse/presentation/widgets/config_title_widget.dart';
import 'package:smerse/presentation/widgets/next_button_widget.dart';

import '../../constants.dart';
import '../blocs/user_config_bloc/user_config_bloc.dart';
import '../widgets/option_radio_button_widget.dart';

class ChooseSplitScreen extends StatelessWidget {
  const ChooseSplitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context
        .select((UserConfigBloc bloc) => bloc.state.selectedSplitIndexes);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const ConfigTitleWidget(
            title: '''How would you like to train?''',
            subtitle:
                '''Select the options below in order of your preference''',
          ),
          const SizedBox(height: 30),
          Column(
            children: List.generate(
              splits.length,
              (index) => OptionRadioButtonWidget(
                onTap: () => context.read<UserConfigBloc>().add(
                      SplitButtonTapped(index: index),
                    ),
                isSelected: list.contains(index),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        splits.keys.toList()[index],
                        color: list.contains(index) ? Colors.white : null,
                      ),
                      const SizedBox(width: 30),
                      Text(splits.values.toList()[index])
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: NextButtonWidget(
              isEnable: list.isNotEmpty,
              enableCallback: () {
                context.read<UserConfigBloc>().add(NextButtonTapEvent());
              },
              disableCallback: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Choose at least one split'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
