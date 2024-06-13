class Challenges {
  final List<Challenge> daily;
  final List<Challenge> weekly;
  final List<Challenge> monthly;

  List<Challenge> get allChallenges => [...daily, ...weekly, ...monthly];

  Challenges(
      {required this.daily, required this.weekly, required this.monthly});
}

class Challenge {
  int id;
  String title;
  String description;
  DueType dueType;
  ChallengeType challengeType;
  int points;
  bool isFinished;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.dueType,
    required this.challengeType,
    required this.points,
    required this.isFinished,
  });
}

enum DueType { daily, weekly, monthly }

enum ChallengeType { distanceChallenge, timeChallenge }
