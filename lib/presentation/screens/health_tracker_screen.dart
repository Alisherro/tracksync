import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tracksync/constants.dart';
import 'package:tracksync/presentation/blocs/results_list_cubit/results_list_cubit.dart';

class HealthTrackerScreen extends StatelessWidget {
  const HealthTrackerScreen({super.key});

  static const TextStyle style = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 16,
    fontFamily: 'EurostileRound',
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Health Tracker',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
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
                                      data: cupertinoPickerStyle,
                                      child: CupertinoDatePicker(
                                        initialDateTime: DateTime.now(),
                                        mode: CupertinoDatePickerMode.monthYear,
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
                                  ?.copyWith(color: blueColor),
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
                                    const Text('Running'),
                                    Text(
                                      '${state.totalKm > 10 ? state.totalKm.toInt() : state.totalKm.toStringAsFixed(2)}km',
                                      style: style.copyWith(color: secondColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Time'),
                                    Text(
                                      '${hoursStr(state.totalDuration.inSeconds)}:${minutesStr(state.totalDuration.inSeconds)}:${secondsStr(state.totalDuration.inSeconds)}',
                                      style: style,
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
                                    const Text('Calories'),
                                    Text(
                                      '${state.totalCalories}kCal',
                                      style: style.copyWith(color: secondColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Workouts'),
                                    Text(
                                      state.totalWorkouts.toString(),
                                      style: style,
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
                const SizedBox(height: 40),
                ListView.builder(
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
                                    const EdgeInsets.only(top: 10, left: 40),
                                child: Text(
                                  date,
                                  style: style,
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.5),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/health/result/${data.id}');
                            },
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: emptyColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              width: 2,
                                              color: pinkColor,
                                            ),
                                          ),
                                          width: 55,
                                          height: 55,
                                          child: SvgPicture.asset(
                                              'assets/images/running_icon.svg'),
                                        ),
                                        const SizedBox(width: 15),
                                        FittedBox(
                                          child: Column(
                                            children: [
                                              Text(
                                                '${data.distance?.toStringAsFixed(2) ?? '0'}km',
                                                style: style.copyWith(
                                                    color: secondColor),
                                              ),
                                              Text(
                                                '${hoursStr(data.totalSeconds ?? 0)}:${minutesStr(data.totalSeconds ?? 0)}:${secondsStr(data.totalSeconds ?? 0)}',
                                                style: style,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(timeAgo(data.dateTime!)),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: redColor,
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
