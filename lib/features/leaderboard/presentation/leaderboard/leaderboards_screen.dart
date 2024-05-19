import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracksync/core/core.dart';

import '../../../../../utils/helper/helper.dart';
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

  String getPeriodName(TimePeriod period){
     switch(period){
       case TimePeriod.day :return 'Today';
       case TimePeriod.week :return 'Week';
       case TimePeriod.month :return 'Month';
       case TimePeriod.all :return 'All time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Leaderboard',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Flexible(
            child: TabBar(
              indicatorColor: Palette.limeGreen,
              splashBorderRadius: BorderRadius.zero,
              padding: EdgeInsets.zero,
              controller: _controller,
              labelColor: Palette.limeGreen,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
              labelPadding: const EdgeInsets.all(10),
              unselectedLabelColor: Palette.subText,
              tabs: context.read<LeaderboardCubit>().tabs
                  .map(
                    (e) => Text(getPeriodName(e)),
                  )
                  .toList(),
              onTap: (int index) {
                BlocProvider.of<LeaderboardCubit>(context).filterChanged(index);
              },
              splashFactory: NoSplash.splashFactory,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<LeaderboardCubit, LeaderboardState>(
            builder: (context, state) {
              if (state is LeaderboardSuccess) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: state.leaderboard.leaders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LeaderboardUserWidget(
                      leader: state.leaderboard.leaders[index],
                      index: index,
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}

class LeaderboardUserWidget extends StatelessWidget {
  const LeaderboardUserWidget(
      {super.key, required this.leader, required this.index});

  final Leader leader;
  final int index;

  @override
  Widget build(BuildContext context) {
    return RoundedShadowContainer(
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
          SvgPicture.asset(Images.avatar),
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
    ));
  }
}
