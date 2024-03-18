import 'leader.dart';

class Leaderboard {
  Leaderboard({required this.leaders});

  final List<Leader> leaders;
}

class LeaderboardParams {
  const LeaderboardParams(this.filter);

  final String filter;
}
