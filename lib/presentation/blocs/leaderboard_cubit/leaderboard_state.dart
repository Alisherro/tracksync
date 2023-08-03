part of 'leaderboard_cubit.dart';

@immutable
abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  LeaderboardLoaded(this.users, [this.leaderboardFilterIndex]);

  final int? leaderboardFilterIndex;
  final List<User> users;
}
