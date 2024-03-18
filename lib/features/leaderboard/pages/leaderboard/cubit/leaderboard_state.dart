part of 'leaderboard_cubit.dart';

@immutable
abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardSuccess extends LeaderboardState {
  LeaderboardSuccess(this.leaderboard);

  final Leaderboard leaderboard;
}

class LeaderboardFailed extends LeaderboardState {
  LeaderboardFailed(this.failure);

  final Failure failure;
}
