import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smerse/constants.dart';
import 'package:smerse/presentation/blocs/leaderboard_cubit/leaderboard_cubit.dart';

import '../widgets/leaderboard_user_widget.dart';

class LeaderboardsScreen extends StatelessWidget {
  const LeaderboardsScreen({super.key});

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
                      color: emptyColor,
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
                                  color: (state is LeaderboardLoaded)
                                      ? state.leaderboardFilterIndex == index
                                          ? redColor
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
            if (state is LeaderboardLoaded) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: state.users.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return LeaderboardUserWidget(
                    user: state.users[index],
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
