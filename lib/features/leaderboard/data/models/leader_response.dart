import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/leader.dart';

class LeaderResponse {
  String? totalPoints;
  num? distance;
  User? user;

  LeaderResponse({this.totalPoints, this.distance, this.user});

  LeaderResponse.fromJson(Map<String, dynamic> json) {
    totalPoints = json['total_points'];
    distance = json['distance'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Leader? toEntity() {
    if ([user, totalPoints, distance].contains(null)) {
      return null;
    }
    return Leader(user: user!, totalPoints: totalPoints!, totalKm: distance.toString());
  }
}
