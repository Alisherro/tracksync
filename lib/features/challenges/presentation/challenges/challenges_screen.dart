import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/features/challenges/domain/entities/challenge.dart';

import '../../../../core/core.dart';
import 'bloc/challenges_bloc.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        switch (state) {
          case ChallengesError():
            {
              return const Center(child: Text('Error'));
            }
          case ChallengesLoading():
            {
              return const Center(child: CircularProgressIndicator());
            }

          case ChallengesLoaded():
            {
              final List<Challenge> challenges = state.challenges;
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
                            challenge: challenges[index],
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription({super.key, required this.challenge, this.onTap});

  final Challenge challenge;
  final Function()? onTap;

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
                      challenge.id.toString(),
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
              Text(
                challenge.points.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              SvgPicture.asset(Images.bolt),
            ],
          ),
        ),
      ),
    );
  }
}
