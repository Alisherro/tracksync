import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/config/constants.dart';
import 'package:tracksync/presentation/widgets/next_button_widget.dart';
import 'package:tracksync/presentation/widgets/pop_button_widget.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: PopButtonWidget(
            title: 'COMMUNITIES',
            onTap: () =>context.pop(),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: emptyColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IntrinsicWidth(
                  child: Column(
                    children: [
                      Text(
                        'SUBSCRIBERS (0)',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: redColor,
                            fontFamily: 'EurostileRound'),
                      ),
                      const Divider(
                        color: redColor,
                        thickness: 1,
                      )
                    ],
                  ),
                ),
                IntrinsicWidth(
                  child: Column(
                    children: [
                      Text(
                        'SUBSCRIPTION (0)',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'EurostileRound'),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    teamIcon,
                    color: redColor,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'There is no one here yet. Share your profile so others can find you',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: NextButtonWidget(
                      isEnable: true,
                      enableCallback: () {},
                      disableCallback: () {},
                      title: 'Share profile',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 70)
      ],
    );
  }
}
