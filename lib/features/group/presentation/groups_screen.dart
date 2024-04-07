import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => context.go('/groups/community'),
          child: DecoratedBox(
            decoration: const BoxDecoration(
                // color: Palette.emptyColor,
                ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Community & My groups',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          color: Palette.text,
                        )
                      ]),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Images.usersmore,
                        // color: Palette.redColor,
                        width: 44,
                        height: 44,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Subscriptions and communication',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                            'Inspire and motivate others',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Palette.subText),
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
              // color: Palette.emptyColor,
              ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover people!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 20),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 80) / 2,
                        child: DiscoveryButtonWidget(
                          title: 'TWITTER',
                          icon: SizedBox(
                            height: 60,
                            child: SvgPicture.asset(Images.twitter),
                          ),
                          subtitle: 'Follow friends from Twitter',
                          onTap: () async {
                            if (!await launchUrl(
                                Uri.parse('https://twitter.com'))) {
                              throw Exception('Could not launch');
                            }
                          },
                          buttonText: 'Connect',
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 80) / 2,
                        child: DiscoveryButtonWidget(
                          title: 'DISCORD',
                          icon: SizedBox(
                            height: 60,
                            child: SvgPicture.asset(Images.discord),
                          ),
                          subtitle: 'Follow friends from Discord',
                          onTap: () async {
                            if (!await launchUrl(
                                Uri.parse('https://discord.com'))) {
                              throw Exception('Could not launch');
                            }
                          },
                          buttonText: 'Connect',
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'My groups (0)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                  'Get in loop and a group! Community is the best way to keep motivated, make progress and reach your goals.',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: RoundedShadowContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(Images.groupChatGreen),
                  const SizedBox(width: 20),
                  Text('Start by creating your own group!',
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class DiscoveryButtonWidget extends StatelessWidget {
  const DiscoveryButtonWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onTap,
      required this.buttonText});

  final String title;
  final String subtitle;
  final Widget icon;
  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return RoundedShadowContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 5),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Palette.black)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                ),
                textStyle: MaterialStatePropertyAll(
                    Theme.of(context).textTheme.bodySmall),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: Palette.electricBlue)),
                ),
              ),
              onPressed: onTap,
              child: Text(
                buttonText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Palette.electricBlue, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
