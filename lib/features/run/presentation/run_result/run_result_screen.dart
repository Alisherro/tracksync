import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracksync/features/run/presentation/run_result/cubit/run_result_cubit.dart';

import '../../../../../utils/utils.dart';
import '../../../../core/core.dart';
import '../../domain/entities/run_result.dart';
import '../run_history/cubit/results_list_cubit.dart';

class RunResultScreen extends StatelessWidget {
  const RunResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunResultCubit, RunResultState>(
      builder: (context, state) {
        if (state is RunResultSuccess) {
          final RunResult result = state.result;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  PopButtonWidget(
                    title: 'Health Tracker',
                    onTap: () {
                      context.read<ResultsListCubit>().initState();
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Running',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(width: 10),
                      Text(
                        timeAgo(state.result.dateTime!),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Palette.subText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  RoundedShadowContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(Images.runningBlue),
                            const SizedBox(width: 30),
                            Column(
                              children: [
                                Text(
                                  'Total time',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Text(
                                    '${hoursStr(result.totalSeconds ?? 0)}:${minutesStr(result.totalSeconds ?? 0)}:${secondsStr(result.totalSeconds ?? 0)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Palette.electricBlue)),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children: [
                                Text(
                                  'Distance',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Text('${result.distance?.toStringAsFixed(2)}km',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Palette.electricBlue)),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children: [
                                Text(
                                  'Calories',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Text('${result.kcal?.toStringAsFixed(2)}kCal',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Palette.electricBlue)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedShadowContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Text(
                                  'Total Calories',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  '${result.kcal?.toStringAsFixed(2)} kCal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Palette.limeGreen,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        RoundedShadowContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Text('Elevation Gain',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  '54 Ft',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Palette.limeGreen,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        RoundedShadowContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Text('Heart Rate',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  '120 Bpm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Palette.limeGreen,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        'Heart Rate',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '123Bpm AVG',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Palette.electricBlue,
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              colors: [
                                Palette.secondColor,
                                Palette.secondColor
                              ],
                            ),
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(
                              show: false,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: const Color(0xff11BB8D).withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Route map',
                    style: Theme.of(context).textTheme.titleMedium,
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
                        zoom: 13.5,
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
