import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/presentation/widgets/config_title_widget.dart';
import 'package:tracksync/presentation/widgets/next_button_widget.dart';
import '../../constants.dart';
import '../blocs/user_config_bloc/user_config_bloc.dart';
import '../widgets/detail_select_button_widget.dart';

class ChooseDetailsScreen extends StatelessWidget {
  const ChooseDetailsScreen({super.key});

  static const int _minHeight = 50;
  static const int _minWeight = 30;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UserConfigBloc>();
    final date = bloc.state.dateTime;
    final height = bloc.state.height;
    final weight = bloc.state.weight;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const ConfigTitleWidget(
            title: 'Give your Coach some final details',
            subtitle:
                'This information helps your Coach design a Training Journey that’s customized and safe',
          ),
          const SizedBox(height: 30),
          DetailSelectButtonWidget(
            title: date == null
                ? 'Date of birth'
                : '${date.day}-${date.month}-${date.year}',
            onSelect: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 216,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  color: Colors.white,
                  child: SafeArea(
                    top: false,
                    child: CupertinoTheme(
                      data: cupertinoPickerStyle,
                      child: CupertinoDatePicker(
                        initialDateTime: date ?? DateTime(2000, 1, 1),
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newDate) {
                          bloc.add(
                            DateOfBirthChosen(dateTime: newDate),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          DetailSelectButtonWidget(
            title: weight == null ? 'Weight' : weight.toString(),
            onSelect: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 216,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  color: Colors.white,
                  child: SafeArea(
                    top: false,
                    child: CupertinoTheme(
                      data: cupertinoPickerStyle,
                      child: CupertinoPicker(
                        itemExtent: 30,
                        onSelectedItemChanged: (int newValue) {
                          bloc.add(WeightChosen(weight: newValue + _minWeight));
                        },
                        backgroundColor: Colors.white,
                        scrollController: FixedExtentScrollController(
                            initialItem:
                                weight == null ? 0 : weight - _minWeight),
                        children: List.generate(
                          200,
                          (index) => Text(
                            (index + _minWeight).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          DetailSelectButtonWidget(
            title: height == null ? 'Height' : height.toString(),
            onSelect: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 216,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  color: Colors.white,
                  child: SafeArea(
                    top: false,
                    child: CupertinoTheme(
                      data: cupertinoPickerStyle,
                      child: CupertinoPicker(
                        itemExtent: 30,
                        onSelectedItemChanged: (int newValue) {
                          bloc.add(HeightChosen(height: newValue + _minHeight));
                        },
                        backgroundColor: Colors.white,
                        scrollController: FixedExtentScrollController(
                            initialItem:
                                height == null ? 0 : height - _minHeight),
                        children: List.generate(
                          200,
                          (index) => Text(
                            (index + _minHeight).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: NextButtonWidget(
              isEnable: ![
                bloc.state.height,
                bloc.state.weight,
                bloc.state.dateTime
              ].contains(null),
              enableCallback: () {
                context.read<UserConfigBloc>().add(FinishButtonTapEvent());
                context.go('/run');
              },
              disableCallback: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: snackBarDuration,
                    content: Text('Fill all the details'),
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
