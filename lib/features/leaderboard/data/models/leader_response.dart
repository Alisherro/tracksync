import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/leader.dart';

class LeaderResponse {
  String? totalPoints;
  String? totalDistance;
  User? user;

  LeaderResponse({this.totalPoints, this.totalDistance, this.user});

  LeaderResponse.fromJson(Map<String, dynamic> json) {
    totalPoints = json['total_points'];
    totalDistance = json['total_distance'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Leader? toEntity() {
    if ([user, totalPoints, totalDistance].contains(null)) {
      return null;
    }
    return Leader(user: user!, totalPoints: totalPoints!, totalKm: totalDistance!);
  }
}
