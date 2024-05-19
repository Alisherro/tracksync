import 'package:tracksync/features/challenges/domain/entities/challenge.dart';

class ChallengeResponse {
  int? id;
  String? title;
  String? description;
  String? dueType;
  String? challengeType;
  int? isActive;
  int? points;

  ChallengeResponse(
      {this.id,
      this.title,
      this.description,
      this.dueType,
      this.challengeType,
      this.isActive,
      this.points});

  ChallengeResponse.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    dueType = json['due_type'];
    challengeType = json['challenge_type'];
    isActive = json['is_active'];
    points = json['points'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['due_type'] = this.dueType;
    data['challenge_type'] = this.challengeType;
    data['is_active'] = this.isActive;
    data['points'] = this.points;
    return data;
  }

  Challenge? toEntity() {
    if ([id, title, description, points].contains(null)) {
      return null;
    }
    bool isActiveE = isActive == 1;
    DueType? dueTypeE;
    ChallengeType? challengeTypeE;

    switch (dueType) {
      case null || '':
        return null;

      case 'daily':
        dueTypeE = DueType.daily;

      case 'weekly':
        dueTypeE = DueType.weekly;

      case 'monthly':
        dueTypeE = DueType.monthly;
    }

    switch (challengeType) {
      case null || '':
        return null;
      case 'distanceChallenge':
        challengeTypeE = ChallengeType.distanceChallenge;
    }

    return Challenge(
      id: id!,
      title: title!,
      description: description!,
      dueType: dueTypeE!,
      challengeType: challengeTypeE!,
      isActive: isActiveE,
      points: points!,
    );
  }
}
