import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/images.dart';
import '../../../../core/resources/palette.dart';
import '../../../../core/widgets/rounded_shadow_container.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Challenges for today',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ChallengeDescription(index: index);
              },
            )
          ],
        ),
      ),
    );
  }
}

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription({super.key, required this.index});

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
                child: FittedBox(
                  child: Text(
                    (index + 1).toString(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    'Run 10km',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  '5hrs left',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Palette.electricBlue),
                ),
              ],
            ),
            const Spacer(),
            Text(
              '500',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset(Images.bolt),
          ],
        ),
      ),
    );
  }
}
