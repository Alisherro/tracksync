import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracksync/core/core.dart';
import '../bloc/user_config_bloc.dart';
import '../widgets/config_title_widget.dart';

class ChooseGenderScreen extends StatelessWidget {
  const ChooseGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool? isMale =
        context.select((UserConfigBloc bloc) => (bloc.state as UserConfigStateData).isMale);
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
                      color: isMale == null || isMale
                          ? Palette.emptyColor
                          : Palette.sunsetOrange,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 260,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.femaleAvatar,
                              width: 50, height: 50),
                          const SizedBox(height: 10),
                          Text(
                            'Female',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Palette.background),
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
                      color: isMale == null || !isMale
                          ? Palette.emptyColor
                          : Palette.sunsetOrange,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 260,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Images.maleAvatar,
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Male',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Palette.background),
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
            child: Button(
              title: 'Next',
              onPressed: isMale == null
                  ? null
                  : () {
                      context.read<UserConfigBloc>().add(NextButtonTapEvent());
                    },
              color: isMale == null ? Palette.emptyColor : null,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
