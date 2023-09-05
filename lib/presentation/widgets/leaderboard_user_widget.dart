import 'package:flutter/material.dart';
import 'package:tracksync/constants.dart';

import '../../data/models/user.dart';

class LeaderboardUserWidget extends StatelessWidget {
  const LeaderboardUserWidget(
      {super.key, required this.user, required this.index});

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: emptyColor,
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
                            ? orangeColor
                            : index == 1
                                ? blueColor
                                : index == 2
                                    ? greenColor
                                    : Colors.white,
                        fontFamily: 'EurostileRound'),
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(xMenAvatar),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.nickName ?? 'NoName'),
                      const SizedBox(height: 5),
                      Text(
                        '${user.totalKm ?? '0'}km',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'EurostileRound',
                            color: orangeColor),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${user.coins ?? 0}',
                    style: const TextStyle(
                        fontFamily: 'EurostileRound',
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: orangeColor),
                  ),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 11,
                    backgroundImage: AssetImage(logo),
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
