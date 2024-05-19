import 'package:tracksync/features/leaderboard/data/models/leader_response.dart';
import 'package:tracksync/features/leaderboard/domain/entities/leader.dart';
import 'package:tracksync/features/leaderboard/domain/entities/leaderboard.dart';

class LeaderboardResponse {
  List<LeaderResponse>? leaders;

  LeaderboardResponse({this.leaders});

  LeaderboardResponse.fromMap(Map<String, dynamic> json) {
    if (json['data'] != null) {
      leaders = <LeaderResponse>[];
      json['data'].forEach((v) {
        leaders!.add(LeaderResponse.fromJson(v));
      });
    }
  }

  Leaderboard toEntity() {
    return Leaderboard(
        leaders: leaders!
            .map((e) => e.toEntity())
            .where((e) => e != null)
            .cast<Leader>()
            .toList());
  }
}
