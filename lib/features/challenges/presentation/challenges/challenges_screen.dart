import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracksync/features/challenges/domain/entities/challenge.dart';
import 'package:tracksync/utils/ext/ext.dart';

import '../../../../core/core.dart';
import 'bloc/challenges_bloc.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChallengesBloc, ChallengesState>(
      listener: (context, state) {
        if (state is SChallengeSuccess) {
          'You completed challenge!'.toToastSuccess(context);
        }
      },
      buildWhen: (prev, cur) {
        return [ChallengesLoading, ChallengesLoaded, ChallengesError]
            .contains(cur.runtimeType);
      },
      builder: (context, state) {
        if (state is ChallengesLoaded) {
          final List<Challenge> challenges = state.challenges.allChallenges;
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
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: 6,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ChallengeDescription(
                          challenge: challenges[index], index: index);
                    },
                  )
                ],
              ),
            ),
          );
        } else if (state is ChallengesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription(
      {super.key, required this.challenge, this.onTap, required this.index});

  final Challenge challenge;
  final Function()? onTap;
  final int index;

  bool get isFinished => challenge.isFinished;

  int get _index => index + 1;

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
                  child: FittedBox(
                    child: Text(
                      _index.toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      challenge.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Palette.electricBlue),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              if (!isFinished) ...[
                Text(
                  challenge.points.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                SvgPicture.asset(Images.bolt),
              ],
              if (isFinished)
                Icon(
                  Icons.check,
                  color: Palette.limeGreen,
                )
            ],
          ),
        ),
      ),
    );
  }
}
