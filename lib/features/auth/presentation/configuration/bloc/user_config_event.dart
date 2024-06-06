part of 'user_config_bloc.dart';

@immutable
abstract class UserConfigEvent {}

class ChooseGenderEvent extends UserConfigEvent {
  ChooseGenderEvent({this.isMale});

  final bool? isMale;
}

class GoalButtonTapped extends UserConfigEvent {
  GoalButtonTapped({required this.index});

  final int index;
}

class DateOfBirthChosen extends UserConfigEvent {
  DateOfBirthChosen({required this.dateTime});

  final DateTime dateTime;
}

class WeightChosen extends UserConfigEvent {
  WeightChosen({required this.weight});

  final int weight;
}

class HeightChosen extends UserConfigEvent {
  HeightChosen({required this.height});

  final int height;
}

class FitnessLevelChosen extends UserConfigEvent {
  FitnessLevelChosen({required this.percentage});

  final double percentage;
}

class NextButtonTapEvent extends UserConfigEvent {}
class FinishButtonTapEvent extends UserConfigEvent {}
