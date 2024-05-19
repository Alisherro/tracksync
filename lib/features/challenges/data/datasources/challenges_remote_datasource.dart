import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:tracksync/core/core.dart';
import 'package:tracksync/features/challenges/data/models/challenge_response.dart';

abstract interface class ChallengesRemoteDataSource {
  Future<Either<Failure, List<ChallengeResponse>>> getChallenges();
}

class ChallengesRemoteDataSourceImpl implements ChallengesRemoteDataSource {
  ChallengesRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<Either<Failure, List<ChallengeResponse>>> getChallenges() async {
    return await _client.getRequest(
      ListAPI.challenges,
      converter: (response) {
        List<dynamic> data = (response as Map<String, dynamic>)['data'] as List;
        List<ChallengeResponse> list =
            data.map((e) => ChallengeResponse.fromMap(e)).toList();
        return list;
      },
    );
  }
}
