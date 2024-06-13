import 'package:tracksync/features/challenges/domain/entities/challenge.dart';

class ChallengesResponse {
  List<ChallengeResponse>? daily;
  List<ChallengeResponse>? weekly;
  List<ChallengeResponse>? monthly;

  ChallengesResponse({this.daily, this.weekly, this.monthly});

  ChallengesResponse.fromJson(Map<String, dynamic> json) {
    if (json['daily'] != null) {
      daily = <ChallengeResponse>[];
      json['daily'].forEach((v) {
        daily!.add(ChallengeResponse.fromJson(v));
      });
    }
    if (json['weekly'] != null) {
      weekly = <ChallengeResponse>[];
      json['weekly'].forEach((v) {
        weekly!.add(ChallengeResponse.fromJson(v));
      });
    }
    if (json['monthly'] != null) {
      monthly = <ChallengeResponse>[];
      json['monthly'].forEach((v) {
        monthly!.add(ChallengeResponse.fromJson(v));
      });
    }
  }
}

class ChallengeResponse {
  int? id;
  int? userId;
  ChallengeInfo? challenge;
  int? challengeStatus;

  ChallengeResponse(
      {this.id, this.userId, this.challenge, this.challengeStatus});

  ChallengeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    challenge = json['challenge'] != null
        ? new ChallengeInfo.fromJson(json['challenge'])
        : null;
    challengeStatus = json['challenge_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.challenge != null) {
      data['challenge'] = this.challenge!.toJson();
    }
    data['challenge_status'] = this.challengeStatus;
    return data;
  }

  Challenge? toEntity() {
    Challenge? temp = challenge?.toEntity();
    bool isFinishedE = challengeStatus == 1;
    if (temp != null) {
      return temp..isFinished = isFinishedE;
    } else {
      return null;
    }
  }
}

class ChallengeInfo {
  int? id;
  String? title;
  String? description;
  String? dueType;
  String? challengeType;
  int? isActive;
  int? points;

  ChallengeInfo(
      {this.id,
      this.title,
      this.description,
      this.dueType,
      this.challengeType,
      this.isActive,
      this.points});

  ChallengeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    dueType = json['due_type'];
    challengeType = json['challenge_type'];
    isActive = json['is_active'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
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
      case 'distanceChallenge':
        challengeTypeE = ChallengeType.distanceChallenge;
      case 'timeChallenge':
        challengeTypeE = ChallengeType.timeChallenge;
      default:
        challengeTypeE = null;
    }

    return Challenge(
      id: id!,
      title: title!,
      description: description!,
      dueType: dueTypeE!,
      challengeType: challengeTypeE!,
      isFinished: false,
      points: points!,
    );
  }
}
