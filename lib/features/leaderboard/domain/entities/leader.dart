import '../../../auth/domain/entities/user.dart';

class Leader {
  const Leader(
      {required this.user, required this.totalKm, required this.totalPoints});

  final User user;
  final String totalKm;
  final String totalPoints;
}
