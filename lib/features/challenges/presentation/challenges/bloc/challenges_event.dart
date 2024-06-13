part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesEvent {}

class ChallengesFetchEvent extends ChallengesEvent{}
class CheckChallenges extends ChallengesEvent{}


