import 'package:tracksync/features/leaderboard/data/models/leader_response.dart';
import 'package:tracksync/features/leaderboard/domain/entities/leaderboard.dart';

class LeaderboardResponse {
  List<LeaderResponse>? leaders;

  LeaderboardResponse({this.leaders});

  LeaderboardResponse.fromJson(Map<String, dynamic> json) {
    if (json['leaders'] != null) {
      leaders = <LeaderResponse>[];
      json['leaders'].forEach((v) {
        leaders!.add(LeaderResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaders != null) {
      data['leaders'] = leaders!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Leaderboard toEntity() {
    return Leaderboard(
        leaders: leaders?.map((e) => e.toEntity()).toList() ?? []);
  }
}
