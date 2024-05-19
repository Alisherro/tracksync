class Challenge {
  int id;
  String title;
  String description;
  DueType dueType;
  ChallengeType challengeType;
  bool isActive;
  int points;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.dueType,
    required this.challengeType,
    required this.isActive,
    required this.points,
  });
}

enum DueType { daily, weekly, monthly }

enum ChallengeType { distanceChallenge }
