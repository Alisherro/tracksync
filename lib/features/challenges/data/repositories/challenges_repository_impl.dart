import 'package:dartz/dartz.dart';
import 'package:tracksync/core/error/failure.dart';
import 'package:tracksync/features/challenges/domain/entities/challenge.dart';
import 'package:tracksync/features/challenges/domain/repositories/challenges_repository.dart';

import '../datasources/challenges_remote_datasource.dart';

class ChallengesRepositoryImpl implements ChallengesRepository {
  ChallengesRepositoryImpl(this.remoteDatasource);

  final ChallengesRemoteDataSource remoteDatasource;

  @override
  Future<Either<Failure, List<Challenge>>> getChallenges() async {
    final response = await remoteDatasource.getChallenges();
    return response.fold(
      (l) => Left(l),
      (r) {
        final List<Challenge> challenges = r
            .map((challengeResponse) => challengeResponse.toEntity())
            .where((challenge) => challenge != null)
            .cast<Challenge>()
            .toList();
        return Right(challenges);
      },
    );
  }
}
