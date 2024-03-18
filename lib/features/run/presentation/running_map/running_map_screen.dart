import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../utils/helper/helper.dart';
import '../../../../core/localization/generated/strings.dart';
import '../../../../core/resources/palette.dart';
import 'bloc/running_map_bloc.dart';
import 'bloc/running_map_event.dart';

class RunningMapScreen extends StatelessWidget {
  const RunningMapScreen({super.key});

  static const _smallTextStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Palette.mainColor,
  );

  static const _mediumTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: Palette.mainColor,
    fontFamily: 'EurostileRound',
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunningMapBloc, RunningMapState>(
      builder: (context, state) {
        if (state is RunningMapErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is RunningMapAvailableState) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 160),
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  polylines: {
                    Polyline(
                      width: 6,
                      points: state.points,
                      polylineId: PolylineId('runningRoute'),
                      visible: true,
                    )
                  },
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.currentPosition.latitude,
                        state.currentPosition.longitude),
                    zoom: 14.5,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    context.read<RunningMapBloc>().add(
                          MapCreated(controller: controller),
                        );
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('current'),
                      position: LatLng(
                        state.currentPosition.latitude,
                        state.currentPosition.longitude,
                      ),
                    ),
                  },
                ),
              ),
              Positioned(
                left: 40,
                right: 40,
                top: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 30, top: 6, left: 50, right: 50),
                      decoration: BoxDecoration(
                        color: Palette.secondColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              '${hoursStr(state.duration.inSeconds)}:${minutesStr(state.duration.inSeconds)}:${secondsStr(state.duration.inSeconds)}',
                              style: const TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontFamily: 'EurostileRound'),
                            ),
                          ),
                          Text(
                            Strings.of(context)!.dashboard,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            '123BMP',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                fontFamily: 'EurostileRound'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  state.distance.toStringAsFixed(2),
                                  style: _mediumTextStyle,
                                ),
                                const Text(
                                  'Distance',
                                  style: _smallTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  '${state.kcal.toStringAsFixed(1)}k',
                                  style: _mediumTextStyle,
                                ),
                                const Text(
                                  'Сalories',
                                  style: _smallTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  '${minutesStr(state.avgPace.inSeconds)}:${secondsStr(state.avgPace.inSeconds)}',
                                  style: _mediumTextStyle,
                                ),
                                const Text(
                                  'Avg. pace (min/km)',
                                  style: _smallTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 40,
                right: 40,
                bottom: 20,
                child: SafeArea(
                  child: OutlinedButton(
                    onPressed: () {
                      context
                          .read<RunningMapBloc>()
                          .add(RunButtonTapped(context));
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Palette.redColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                    child: Text(
                      state.isRunning ? 'STOP' : 'START',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
