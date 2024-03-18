import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../entities/leaderboard.dart';

abstract interface class LeaderboardRepository {
  Future<Either<Failure, Leaderboard>> getLeaderboard(LeaderboardParams params);
}
