import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracksync/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracksync/presentation/widgets/next_button_widget.dart';

import '../blocs/user_config_bloc/user_config_bloc.dart';
import '../widgets/config_title_widget.dart';

class ChooseGenderScreen extends StatelessWidget {
  const ChooseGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool? isMale =
        context.select((UserConfigBloc bloc) => bloc.state.isMale);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const ConfigTitleWidget(
            title: 'Choose your gender',
            subtitle:
                'This will help us choose the right running shoes for you',
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMale == null
                          ? emptyColor
                          : isMale
                              ? emptyColor
                              : pinkColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 260,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(femaleSvg),
                          const SizedBox(height: 10),
                          Text(
                            'Female',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    BlocProvider.of<UserConfigBloc>(context)
                        .add(ChooseGenderEvent(isMale: false));
                  },
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMale == null
                          ? emptyColor
                          : isMale
                              ? pinkColor
                              : emptyColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 260,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(maleSvg),
                          const SizedBox(height: 10),
                          Text(
                            'Male',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    BlocProvider.of<UserConfigBloc>(context)
                        .add(ChooseGenderEvent(isMale: true));
                  },
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: NextButtonWidget(
              isEnable: isMale != null,
              enableCallback: () {
                context.read<UserConfigBloc>().add(NextButtonTapEvent());
              },
              disableCallback: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text('You must choose your gender'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
