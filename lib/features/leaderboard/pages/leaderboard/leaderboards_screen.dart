import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../core/resources/resources.dart';
import '../../domain/entities/leader.dart';
import 'cubit/leaderboard_cubit.dart';

class LeaderboardsPage extends StatelessWidget {
  const LeaderboardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leaderboards'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Palette.emptyColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
                        builder: (context, state) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            3,
                            (index) => GestureDetector(
                              onTap: () =>
                                  BlocProvider.of<LeaderboardCubit>(context)
                                      .filterChanged(index),
                              child: Text(
                                leaderboardFilter[index],
                                style: TextStyle(
                                  color: (state is LeaderboardSuccess)
                                      ? context
                                                  .read<LeaderboardCubit>()
                                                  .leaderboardFilterIndex ==
                                              index
                                          ? Palette.redColor
                                          : Colors.white
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<LeaderboardCubit, LeaderboardState>(
              builder: (context, state) {
                if (state is LeaderboardSuccess) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 5),
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
          })
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
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Palette.emptyColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: index == 0
                            ? Palette.orangeColor
                            : index == 1
                                ? Palette.blueColor
                                : index == 2
                                    ? Palette.greenColor
                                    : Colors.white,
                        fontFamily: 'EurostileRound'),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(Images.xMenAvatar),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(leader.nickName ?? 'NoName'),
                      const SizedBox(height: 5),
                      Text(
                        '${leader.totalKm ?? '0'}km',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'EurostileRound',
                            color: Palette.orangeColor),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${leader.coins ?? 0}',
                    style: const TextStyle(
                        fontFamily: 'EurostileRound',
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Palette.orangeColor),
                  ),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 11,
                    backgroundImage: AssetImage(Images.logo),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
