import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smerse/constants.dart';
import 'package:smerse/presentation/widgets/config_title_widget.dart';
import 'package:smerse/presentation/widgets/next_button_widget.dart';

import '../blocs/user_config_bloc/user_config_bloc.dart';

class ChooseLevelScreen extends StatefulWidget {
  const ChooseLevelScreen({super.key});

  @override
  State<ChooseLevelScreen> createState() => _ChooseLevelScreenState();
}

class _ChooseLevelScreenState extends State<ChooseLevelScreen> {
  double width = 120;
  double height = 350;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UserConfigBloc>();
    double? percentage = bloc.state.fitPercentage;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            const ConfigTitleWidget(
                title: 'What are your fitness level ?',
                subtitle:
                    ''' To get a training program with the right level of difficulty, select the option that most closely matches you.'''),
            const SizedBox(height: 20),
            const Text(
              'Really fit',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onVerticalDragStart: (details) {
                double newPercentage =
                    (height - details.localPosition.dy) / height;
                bloc.add(FitnessLevelChosen(percentage: newPercentage));
              },
              onVerticalDragUpdate: (details) {
                double newPercentage =
                    (height - details.localPosition.dy) / height;
                bloc.add(FitnessLevelChosen(percentage: newPercentage));
              },
              child: SizedBox(
                height: height,
                width: width,
                child: ListView.separated(
                  shrinkWrap: true,
                  reverse: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: (width / 2) + (2 * index),
                        height: 2,
                        decoration: BoxDecoration(
                          color: ((index) / 30) < (percentage ?? 0)
                              ? pinkColor
                              : Colors.white,
                          boxShadow: [
                            if (((index) / 30) < (percentage ?? 0))
                              const BoxShadow(
                                color: Color.fromRGBO(255, 103, 107, 1),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: 30,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Not fit at all',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: NextButtonWidget(
                isEnable: bloc.state.fitPercentage != null,
                enableCallback: () {
                  context.read<UserConfigBloc>().add(NextButtonTapEvent());
                },
                disableCallback: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('drag the slider to your level'),
                      duration: snackBarDuration,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
