import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smerse/presentation/blocs/result_cubit/run_result_cubit.dart';

import '../../constants.dart';
import '../../data/models/run_result.dart';
import '../widgets/pop_button_widget.dart';

class RunResultScreen extends StatelessWidget {
  const RunResultScreen({super.key});

  static const TextStyle style = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 16,
    fontFamily: 'EurostileRound',
  );

  @override
  Widget build(BuildContext context) {
    print(GoRouter.of(context).routerDelegate.currentConfiguration.fullPath);
    return BlocBuilder<RunResultCubit, RunResultState>(
      builder: (context, state) {
        if (state is RunResultSuccess) {
          final RunResult result = state.result;
          return Animate(
            effects: const [FadeEffect()],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: PopButtonWidget(
                          title: 'HEALTH TRACKER', onTap: () => context.pop())),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Running',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          timeAgo(state.result.dateTime!),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: emptyColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                        child: FittedBox(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border:
                                        Border.all(width: 2, color: pinkColor),
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/images/running_icon.svg'),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Column(
                                children: [
                                  const Text('Total time'),
                                  Text(
                                    '${hoursStr(result.totalSeconds ?? 0)}:${minutesStr(result.totalSeconds ?? 0)}:${secondsStr(result.totalSeconds ?? 0)}',
                                    style: style.copyWith(color: secondColor),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 30),
                              Column(
                                children: [
                                  const Text('Distance'),
                                  Text(
                                    '${result.distance?.toStringAsFixed(2)}km',
                                    style: style.copyWith(color: pinkColor),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 30),
                              Column(
                                children: [
                                  const Text('Calories'),
                                  Text(
                                    '${result.kcal?.toStringAsFixed(2)}kCal',
                                    style: style.copyWith(color: blueColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total Calories',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    '${result.kcal?.toStringAsFixed(2)}kCal',
                                    style: style.copyWith(color: blueColor),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Elevation Gain',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text(
                                    '54Ft',
                                    style: style.copyWith(color: orangeColor),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Heart Rate',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text(
                                    '120Bpm',
                                    style: style.copyWith(color: secondColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Heart Rate',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              '123Bpm AVG',
                              style: style.copyWith(color: blueColor),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        AspectRatio(
                          aspectRatio: 2.5,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                drawHorizontalLine: false,
                                horizontalInterval: 1,
                                verticalInterval: 1,
                                getDrawingVerticalLine: (value) {
                                  return const FlLine(
                                    color: Color(0xff120A27),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              titlesData: const FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  axisNameWidget: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '8:42 AM',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff715BA7),
                                        ),
                                      ),
                                      Text(
                                        '9:42 AM',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff715BA7),
                                        ),
                                      ),
                                      Text(
                                        '10:42 AM',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff715BA7),
                                        ),
                                      ),
                                      Text(
                                        '11:42 AM',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff715BA7),
                                        ),
                                      )
                                    ],
                                  ),
                                  axisNameSize: 30,
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              minX: 0,
                              maxX: 11,
                              minY: 0,
                              maxY: 6,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(0, 3),
                                    FlSpot(2.6, 2),
                                    FlSpot(4.9, 5),
                                    FlSpot(6.8, 3.1),
                                    FlSpot(8, 4),
                                    FlSpot(9.5, 3),
                                    FlSpot(11, 4),
                                  ],
                                  isCurved: true,
                                  gradient: const LinearGradient(
                                    colors: [secondColor, secondColor],
                                  ),
                                  barWidth: 2,
                                  isStrokeCapRound: true,
                                  dotData: const FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: const Color(0xff11BB8D)
                                        .withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Route map',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: GoogleMap(
                            gestureRecognizers: <Factory<
                                OneSequenceGestureRecognizer>>{
                              Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                              ),
                            },
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(51.1478, 71.3571),
                              zoom: 14.5,
                            ),
                            markers: {
                              const Marker(
                                  markerId: MarkerId('a'),
                                  position: LatLng(51.1504, 71.5679)),
                              const Marker(
                                  markerId: MarkerId('b'),
                                  position: LatLng(51.1698, 71.3711)),
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          );
        } else if (state is RunResultInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('No such result'),
          );
        }
      },
    );
  }
}
