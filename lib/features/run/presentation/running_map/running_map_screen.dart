import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../core/core.dart';
import 'bloc/running_map_bloc.dart';
import 'bloc/running_map_event.dart';

class RunningMapScreen extends StatefulWidget {
  const RunningMapScreen({super.key});

  @override
  State<RunningMapScreen> createState() => _RunningMapScreenState();
}

class _RunningMapScreenState extends State<RunningMapScreen> {

@override
  void initState() {
  context.read<RunningMapBloc>().add(InitPermissions());
  super.initState();
  }

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
              GoogleMap(
                zoomControlsEnabled: false,
                polylines: {
                  Polyline(
                    width: 6,
                    points: state.points,
                    polylineId: const PolylineId('runningRoute'),
                    visible: true,
                  )
                },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(state.currentPosition.latitude,
                      state.currentPosition.longitude),
                  zoom: 13.5,
                ),
                onMapCreated: (GoogleMapController controller) {
                  context.read<RunningMapBloc>().add(
                        MapCreated(controller: controller),
                      );
                },
                markers: {
                 if(state.icon!=null) Marker(
                    markerId:const MarkerId('me'),
                    position: LatLng(
                      state.currentPosition.latitude,
                      state.currentPosition.longitude,
                    ),
                    icon: state.icon?? BitmapDescriptor.defaultMarker,
                   anchor: const Offset(0.5, 0.5)
                  ),
                },
                mapToolbarEnabled: false,
                zoomGesturesEnabled: false,
                compassEnabled: false,
              ),
              Positioned(
                left: 40,
                right: 40,
                top: 30,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 18,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Dashboard',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                    '${hoursStr(state.duration.inSeconds)}:${minutesStr(state.duration.inSeconds)}:${secondsStr(state.duration.inSeconds)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                    textAlign: TextAlign.center),
                                // const SizedBox(height: 15),
                                // Text('128 Bpm',
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .titleLarge
                                //         ?.copyWith(color: Palette.limeGreen),
                                //     textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Flexible(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      Flexible(
                        flex: 7,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      state.distance.toStringAsFixed(2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Distance',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Palette.subText),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text(
                                      '${state.kcal.toStringAsFixed(1)}k',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Сalories',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Palette.subText),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text(
                                      '${minutesStr(state.avgPace.inSeconds)}:${secondsStr(state.avgPace.inSeconds)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Avg. pace (min/km)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Palette.subText),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 40,
                right: 40,
                bottom: 20,
                child: SafeArea(
                  child: Button(
                    title: state.isRunning ? 'STOP' : 'START!',
                    onPressed: () {
                      context
                          .read<RunningMapBloc>()
                          .add(RunButtonTapped(context));
                    },
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
