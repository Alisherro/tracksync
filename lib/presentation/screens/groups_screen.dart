import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smerse/constants.dart';

import '../widgets/discovery_button_widget.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  static const TextStyle style1 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: greyColor,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => context.go('/groups/community'),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: emptyColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'COMMUNITY & MY GROUPS'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Icon(
                              Icons.arrow_forward_outlined,
                              color: redColor,
                            )
                          ]),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SvgPicture.asset(
                            teamIcon,
                            color: redColor,
                            width: 44,
                            height: 44,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Subscriptions and communication',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const Text(
                                'Inspire and motivate others',
                                style: style1,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: emptyColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DISCOVERY PEOPLE',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 20),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: (MediaQuery.sizeOf(context).width - 105) / 2,
                            child: DiscoveryButtonWidget(
                              title: 'TWITTER',
                              icon: SizedBox(
                                height: 60,
                                child: SvgPicture.asset(twitter),
                              ),
                              subtitle: 'Follow friends from Twitter',
                              onTap: () {},
                              buttonText: 'CONNECT',
                            ),
                          ),
                          const SizedBox(width: 25),
                          SizedBox(
                            width: (MediaQuery.sizeOf(context).width - 105) / 2,
                            child: DiscoveryButtonWidget(
                              title: 'DISCORD',
                              icon: SizedBox(
                                height: 60,
                                child: SvgPicture.asset(discord),
                              ),
                              subtitle: 'Follow friends from Discord',
                              onTap: () {},
                              buttonText: 'CONNECT',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: emptyColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MY GROUPS (0)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Get in loop and a group! Community is the best way to keep motivated, make progress and reach your goals.',
                              style: style1,
                            ),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    )
                  ],
                ),
                Positioned(
                  bottom: 90,
                  left: MediaQuery.sizeOf(context).width / 2 - 60,
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: GestureDetector(
                      onTap: () => context.go('/groups/create'),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: redColor),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(messageCircle),
                              const SizedBox(height: 5),
                              const Text(
                                'CREATE GROUP',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
