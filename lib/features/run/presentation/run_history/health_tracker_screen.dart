import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tracksync/features/run/presentation/run_history/cubit/results_list_cubit.dart';

import '../../../../../utils/helper/helper.dart';
import '../../../../core/core.dart';

class HealthTrackerScreen extends StatelessWidget {
  const HealthTrackerScreen({super.key});

  static const TextStyle valuestyle = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: Palette.black);

  static const TextStyle keystyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Palette.black,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsListCubit, ResultsListState>(
      builder: (context, state) {
        if (state is ResultsListSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        'Health Tracker',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Palette.black),
                          ),
                          const SizedBox(width: 17),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (c) => Container(
                                  height: 216,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(c).viewInsets.bottom,
                                  ),
                                  color: Colors.white,
                                  child: SafeArea(
                                    top: false,
                                    child: CupertinoTheme(
                                      data: const CupertinoThemeData(
                                        textTheme: CupertinoTextThemeData(
                                          dateTimePickerTextStyle: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff9C95AD),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      child: CupertinoDatePicker(
                                        initialDateTime: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                        use24hFormat: true,
                                        onDateTimeChanged: (DateTime newDate) {
                                          BlocProvider.of<ResultsListCubit>(
                                                  context)
                                              .dateTimeChange(newDate);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              DateFormat.yMMM().format(state.dateRange),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Palette.electricBlue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 17),
                      Row(
                        children: [
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 110) / 2,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Running',
                                      style: keystyle,
                                    ),
                                    Text(
                                      '${state.totalKm > 10 ? state.totalKm.toInt() : state.totalKm.toStringAsFixed(2)}km',
                                      style: valuestyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Time',
                                      style: keystyle,
                                    ),
                                    Text(
                                      '${hoursStr(state.totalDuration.inSeconds)}:${minutesStr(state.totalDuration.inSeconds)}:${secondsStr(state.totalDuration.inSeconds)}',
                                      style: valuestyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 110) / 2,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Calories',
                                      style: keystyle,
                                    ),
                                    Text('${state.totalCalories}kCal',
                                        style: valuestyle),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Workouts',
                                      style: keystyle,
                                    ),
                                    Text(
                                      state.totalWorkouts.toString(),
                                      style: valuestyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    final data = state.results[index];
                    String previousDate = index > 0
                        ? DateFormat('dd.MM.yy').format(
                            state.results[index - 1].dateTime ?? DateTime(2004))
                        : '';
                    String date = DateFormat('dd.MM.yy')
                        .format(data.dateTime ?? DateTime(2004));
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        date != previousDate
                            ? Padding(
                          padding:
                                    const EdgeInsets.only(bottom: 10, top: 20),
                                child: Text(
                                  date,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/health/result/${data.id}');
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Palette.background,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Palette.black.withAlpha(10),
                                      spreadRadius: 0,
                                      blurRadius: 16,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: 55,
                                          height: 55,
                                          child: SvgPicture.asset(
                                              Images.runningGreen),
                                        ),
                                        const SizedBox(width: 15),
                                        FittedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${data.distance?.toStringAsFixed(2) ?? '0'} km',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                              Text(
                                                  '${hoursStr(data.totalSeconds ?? 0)}:${minutesStr(data.totalSeconds ?? 0)}:${secondsStr(data.totalSeconds ?? 0)}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Text(timeAgo(data.dateTime!)),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Palette.limeGreen,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
