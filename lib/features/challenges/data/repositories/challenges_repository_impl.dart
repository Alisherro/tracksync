import 'package:dartz/dartz.dart';
import 'package:tracksync/core/error/failure.dart';
import 'package:tracksync/features/challenges/domain/entities/challenge.dart';
import 'package:tracksync/features/challenges/domain/repositories/challenges_repository.dart';

import '../datasources/challenges_remote_datasource.dart';

class ChallengesRepositoryImpl implements ChallengesRepository {
  ChallengesRepositoryImpl(this.remote);

  final ChallengesRemoteDataSource remote;

  @override
  Future<Either<Failure, Challenges>> getChallenges() async {
    final response = await remote.getChallenges();
    return response.fold(
          (l) => Left(l),
          (r) {
        return Right(Challenges(
          daily: r.daily?.map((e) => e.toEntity()).where((element) =>
          element != null).cast<Challenge>().toList() ?? [],
          weekly: r.weekly?.map((e) => e.toEntity()).where((
              element) => element != null).cast<Challenge>().toList() ?? [],
          monthly: r.monthly?.map((e) => e.toEntity()).where((
              element) => element != null).cast<Challenge>().toList() ?? [],
        ),);
      },
    );
  }


  @override
  Future<Either<Failure, bool?>> checkChallenges() async {
    return await remote.checkChallenges();

  }
}
