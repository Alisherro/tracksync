import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracksync/core/core.dart';

import '../../../../../utils/helper/helper.dart';
import '../../../../core/widgets/avatar_circle_widget.dart';
import '../../../../core/widgets/profile_widget.dart';
import '../../domain/entities/leader.dart';
import 'cubit/leaderboard_cubit.dart';

class LeaderboardsScreen extends StatefulWidget {
  const LeaderboardsScreen({super.key});

  @override
  State<LeaderboardsScreen> createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends State<LeaderboardsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  String getPeriodName(TimePeriod period) {
    switch (period) {
      case TimePeriod.day:
        return 'Today';
      case TimePeriod.week:
        return 'Week';
      case TimePeriod.month:
        return 'Month';
      case TimePeriod.all:
        return 'All time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Leaderboard',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            height: 48,
            child: TabBar(
              controller: _controller,
              labelColor: Palette.limeGreen,
              unselectedLabelColor: Palette.subText,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
              indicatorColor: Palette.limeGreen,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: context
                  .read<LeaderboardCubit>()
                  .tabs
                  .map((e) => Text(getPeriodName(e)))
                  .toList(),
              onTap: (int index) {
                BlocProvider.of<LeaderboardCubit>(context).filterChanged(index);
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
              builder: (context, state) {
                if (state is LeaderboardSuccess) {
                  if (state.leaderboard.leaders.isNotEmpty) {
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: state.leaderboard.leaders.length,
                      itemBuilder: (context, index) {
                        return LeaderboardUserWidget(
                          leader: state.leaderboard.leaders[index],
                          index: index,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 600, // Maximum width
                                      maxHeight: MediaQuery.of(context).size.height * 0.8, // Maximum height is 80% of the screen height
                                    ),
                                    child: SingleChildScrollView(
                                      child: ProfileWidget(
                                        user: state.leaderboard.leaders[index].user,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },


                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Empty'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardUserWidget extends StatelessWidget {
  const LeaderboardUserWidget(
      {super.key,
      required this.leader,
      required this.index,
      required this.onTap});

  final Leader leader;
  final int index;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RoundedShadowContainer(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            SizedBox(
              width: 15,
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            const SizedBox(width: 10),
            AvatarCircleWidget(
              diameter: kToolbarHeight - 5,
              imageUrl: leader.user.profilePicture,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    leader.user.name ?? 'Unknown',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  '${leader.totalKm} km',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Palette.electricBlue),
                ),
              ],
            ),
            const Spacer(),
            Text(
              leader.totalPoints,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset(Images.bolt),
          ],
        ),
      )),
    );
  }
}
