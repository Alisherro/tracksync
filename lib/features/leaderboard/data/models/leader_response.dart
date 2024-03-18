import 'package:tracksync/features/leaderboard/domain/entities/leader.dart';

class LeaderResponse {
  bool? isMale;
  List<int>? selectedGoalsIndexes;
  List<int>? selectedSplitIndexes;
  String? dateOfBirth;
  int? weight;
  int? height;
  double? fitPercentage;
  int? coins;
  String? nickName;
  String? location;
  double? totalKm;

  LeaderResponse(
      {this.isMale,
      this.selectedGoalsIndexes,
      this.selectedSplitIndexes,
      this.dateOfBirth,
      this.weight,
      this.height,
      this.fitPercentage,
      this.coins,
      this.nickName,
      this.location,
      this.totalKm});

  LeaderResponse.fromJson(Map<String, dynamic> json) {
    isMale = json['isMale'];
    selectedGoalsIndexes = json['selectedGoalsIndexes'].cast<int>();
    selectedSplitIndexes = json['selectedSplitIndexes'].cast<int>();
    dateOfBirth = json['dateOfBirth'];
    weight = json['weight'];
    height = json['height'];
    fitPercentage = json['fitPercentage'];
    coins = json['coins'];
    nickName = json['nickName'];
    location = json['location'];
    totalKm = json['totalKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isMale'] = this.isMale;
    data['selectedGoalsIndexes'] = this.selectedGoalsIndexes;
    data['selectedSplitIndexes'] = this.selectedSplitIndexes;
    data['dateOfBirth'] = this.dateOfBirth;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['fitPercentage'] = this.fitPercentage;
    data['coins'] = this.coins;
    data['nickName'] = this.nickName;
    data['location'] = this.location;
    data['totalKm'] = this.totalKm;
    return data;
  }

  Leader toEntity() {
    return Leader(nickName: nickName, totalKm: totalKm, coins: coins);
  }
}
