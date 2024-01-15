import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/constants.dart';
import 'package:tracksync/presentation/providers/user_provider.dart';

import '../widgets/info_section_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child:  Text(
                  'PROFILE',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      avatar,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nickname',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          FittedBox(
                            child: Text(
                                context.read<UserProvider>().user?.nickName ??
                                    'null',
                              style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: redColor,
                                        fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis
                                      ),
                            ),
                          ),
                          Text(
                            'Male',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(edit),
                  ],
                ),
              ),
            ],
          ),
          DecoratedBox(
            decoration: const BoxDecoration(color: emptyColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'tracksync',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        '234',
                        style: TextStyle(
                          fontFamily: 'EurostileRound',
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          DecoratedBox(
            decoration: const BoxDecoration(color: emptyColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 33, horizontal: 40),
              child: Row(
                children: [
                  Text(
                    '1',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'EurostileRound',
                          color: orangeColor,
                        ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TurBo777',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        '99 level',
                        style: TextStyle(
                          color: orangeColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    '1 456 643',
                    style: TextStyle(
                        color: orangeColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        fontFamily: 'EurostileRound'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          const InfoSectionWidget(
            title: 'LOCATION',
            subtitle: Text(
              'Kazakhstan, Astana',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
          const SizedBox(height: 5),
          const InfoSectionWidget(
            title: 'WEIGHT',
            subtitle: Text(
              '182 lb.',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  fontFamily: 'EurostileRound'),
            ),
          ),
          const SizedBox(height: 5),
          const InfoSectionWidget(
            title: 'HEIGHT',
            subtitle: Text(
              '5\'11\'\'',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  fontFamily: 'EurostileRound'),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              context.go('/profile/groups');
            },
            child: const DecoratedBox(
              decoration: BoxDecoration(color: emptyColor),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Row(
                    children: [
                      Text(
                        'MY GROUPS (1)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'EurostileRound'),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_outlined, color: redColor)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 90)
        ],
      ),
    );
  }
}
