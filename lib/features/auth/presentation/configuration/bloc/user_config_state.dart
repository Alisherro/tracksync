part of 'user_config_bloc.dart';

@immutable
class UserConfigState extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();

}
class UserConfigStateData extends UserConfigState {
   UserConfigStateData({
    this.isMale,
    this.selectedGoalsIndexes = const [],
    this.dateTime,
    this.weight,
    this.height,
    this.fitPercentage,
  });

  final bool? isMale;
  final List<int> selectedGoalsIndexes;
  final DateTime? dateTime;
  final int? weight;
  final int? height;
  final double? fitPercentage;

  @override
  List<Object?> get props =>
      [
        isMale,
        selectedGoalsIndexes,
        dateTime,
        weight,
        height,
        fitPercentage
      ];

  UserConfigStateData copyWith({bool? isMale,
    List<int>? selectedGoalsIndexes,
    DateTime? dateTime,
    int? weight,
    int? height,
    double? fitPercentage}) {
    return UserConfigStateData(
      isMale: isMale ?? this.isMale,
      selectedGoalsIndexes: selectedGoalsIndexes ?? this.selectedGoalsIndexes,
      dateTime: dateTime ?? this.dateTime,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      fitPercentage: fitPercentage ?? this.fitPercentage,
    );
  }

  bool get isFinished =>
      ![isMale,
        selectedGoalsIndexes,
        dateTime,
        weight,
        height,
        fitPercentage].contains(null);

  @override
  String toString() {
    return 'UserConfigState{isMale: $isMale, selectedGoalsIndexes: $selectedGoalsIndexes, dateTime: $dateTime, weight: $weight, height: $height, fitPercentage: $fitPercentage}';
  }

  Map<String, dynamic> toMap() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime!);

    return {
      'isMale': this.isMale,
      'birthDate': formatted,
      'weight_kg': this.weight,
      'height_cm': this.height,
      'fitPercentage': this.fitPercentage,
    };
  }

  factory UserConfigStateData.fromMap(Map<String, dynamic> map) {
    return UserConfigStateData(
      isMale: map['isMale'] as bool,
      selectedGoalsIndexes: map['selectedGoalsIndexes'] as List<int>,
      dateTime: map['dateTime'] as DateTime,
      weight: map['weight'] as int,
      height: map['height'] as int,
      fitPercentage: map['fitPercentage'] as double,
    );
  }
}

class UserConfigStateFailed extends UserConfigState{
  UserConfigStateFailed(this.message);
  final String message;
}
class UserConfigStateLoading extends UserConfigState{
  UserConfigStateLoading();
}
class UserConfigStateSuccess extends UserConfigState{
  UserConfigStateSuccess(this.user);
  final User user;
}