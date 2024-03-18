import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:tracksync/core/core.dart';
import '../../domain/entities/leaderboard.dart';
import '../models/leaderboard_response.dart';

abstract interface class LeaderboardRemoteDataSource {
  Future<Either<Failure, LeaderboardResponse>> getLeaderboard(
      LeaderboardParams params);
}

class LeaderboardRemoteDataSourceMockImpl
    implements LeaderboardRemoteDataSource {
  @override
  Future<Either<Failure, LeaderboardResponse>> getLeaderboard(
      LeaderboardParams params) async {
    final String jsonString =
        await rootBundle.loadString('assets/mock_json/mock_users.json');
    final jsonData = jsonDecode(jsonString);
    LeaderboardResponse response = LeaderboardResponse.fromJson(jsonData);
    return Right(response);
  }
}
