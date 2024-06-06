import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:tracksync/core/core.dart';

import '../../../../../core/widgets/detail_select_button_widget.dart';
import 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart'
as picker_theme;
import '../bloc/user_config_bloc.dart';
import 'config_title_widget.dart';

class ChooseDetailsScreen extends StatelessWidget {
  const ChooseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserConfigBloc, UserConfigState>(
      buildWhen: (context, state)=>state is UserConfigStateData,
      builder: (context, state) {
        state as UserConfigStateData;
        final date = state.dateTime;
        final height = state.height;
        final weight = state.weight;
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
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now().subtract(
                        const Duration(days: 36500)),
                    maxTime: DateTime.now().subtract(
                        const Duration(days: 3000)),
                    onConfirm: (date) {
                      context.read<UserConfigBloc>().add(DateOfBirthChosen(dateTime: date));
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                    theme: const picker_theme.DatePickerTheme(
                      backgroundColor: Palette.background,
                      cancelStyle: TextStyle(color: Palette.emptyColor),
                      doneStyle: TextStyle(color: Palette.sunsetOrange),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Palette.emptyColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Palette.background,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                            hintText: 'Weight',
                            hintStyle: TextStyle(
                              color: Palette.background,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            isDense: true,
                            suffixText: 'kg'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          context
                              .read<UserConfigBloc>()
                              .add(WeightChosen(weight: int.parse(value)));
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Palette.emptyColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Palette.background,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                            hintText: 'Height',
                            hintStyle: TextStyle(
                              color: Palette.background,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            isDense: true,
                            suffixText: 'cm'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          context
                              .read<UserConfigBloc>()
                              .add(HeightChosen(height: int.parse(value)));
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Button(
                  title: 'Finish',
                  onPressed: () {
                    if (![weight, height, date].contains(null)) {
                      context.read<UserConfigBloc>().add(
                          FinishButtonTapEvent());
                    }
                  },
                  color: [weight, height, date].contains(null)
                      ? Palette.emptyColor
                      : null,
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        );
      },
    );
  }
}
