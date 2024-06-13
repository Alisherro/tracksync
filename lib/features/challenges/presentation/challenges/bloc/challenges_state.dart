part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesState {}

final class ChallengesLoading extends ChallengesState {}

final class ChallengesLoaded extends ChallengesState {
  ChallengesLoaded(this.challenges);

  final Challenges challenges;
}

final class ChallengesError extends ChallengesState {}

final class SChallengeSuccess extends ChallengesState {
  SChallengeSuccess();
}
