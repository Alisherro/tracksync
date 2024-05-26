import 'package:dartz/dartz.dart';
import 'package:tracksync/core/error/failure.dart';
import '../../domain/entities/leaderboard.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../datasources/leaderboard_remote_datasource.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  const LeaderboardRepositoryImpl(this.remote);

  final LeaderboardRemoteDataSource remote;

  @override
  Future<Either<Failure, Leaderboard>> getLeaderboard(
      LeaderboardParams params) async {
    final response = await remote.getLeaderboard(params);
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }
}
