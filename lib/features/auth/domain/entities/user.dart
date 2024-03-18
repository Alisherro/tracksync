import 'group.dart';

class User {
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
  List<Group>? groups;
  double? totalKm;

  User(
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
      this.groups,
      this.totalKm});

  User.fromJson(Map<String, dynamic> json) {
    isMale = json['isMale'];
    selectedGoalsIndexes = json['selectedGoalsIndexes'].cast<int>();
    selectedSplitIndexes = json['selectedSplitIndexes'].cast<int>();
    dateOfBirth = json['dateOfBirth'];
    weight = json['weight'];
    height = json['height'];
    fitPercentage = json['fitPercentage'];
    totalKm = json['totalKm'];
    coins = json['coins'];
    nickName = json['nickName'];
    location = json['location'];
    if (json['groups'] != null) {
      groups = <Group>[];
      json['groups'].forEach((v) {
        groups!.add(Group.fromJson(v));
      });
    }
  }
}
