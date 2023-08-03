part of 'user_config_bloc.dart';

@immutable
class UserConfigState extends Equatable {
  const UserConfigState({
    this.isMale,
    this.selectedGoalsIndexes = const [],
    this.selectedSplitIndexes = const [],
    this.dateTime,
    this.weight,
    this.height,
    this.fitPercentage,
  });

  final bool? isMale;
  final List<int> selectedGoalsIndexes;
  final List<int> selectedSplitIndexes;
  final DateTime? dateTime;
  final int? weight;
  final int? height;
  final double? fitPercentage;

  @override
  List<Object?> get props => [
        isMale,
        selectedGoalsIndexes,
        selectedSplitIndexes,
        dateTime,
        weight,
        height,
        fitPercentage
      ];

  UserConfigState copyWith(
      {bool? isMale,
      List<int>? selectedGoalsIndexes,
      List<int>? selectedSplitIndexes,
      DateTime? dateTime,
      int? weight,
      int? height,
      double? fitPercentage}) {
    return UserConfigState(
      isMale: isMale ?? this.isMale,
      selectedGoalsIndexes: selectedGoalsIndexes ?? this.selectedGoalsIndexes,
      selectedSplitIndexes: selectedSplitIndexes ?? this.selectedSplitIndexes,
      dateTime: dateTime ?? this.dateTime,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      fitPercentage: fitPercentage ?? this.fitPercentage,
    );
  }

  @override
  String toString() {
    return 'UserConfigState{isMale: $isMale, selectedGoalsIndexes: $selectedGoalsIndexes, selectedSplitIndexes: $selectedSplitIndexes, dateTime: $dateTime, weight: $weight, height: $height, fitPercentage: $fitPercentage}';
  }
}
