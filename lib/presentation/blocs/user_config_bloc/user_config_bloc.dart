import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_config_event.dart';

part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {
  final PageController pageController = PageController();

  UserConfigBloc() : super(const UserConfigState(selectedGoalsIndexes: [])) {
    on<ChooseGenderEvent>(_onChooseGenderEvent);
    on<NextButtonTapEvent>(_nextButtonTapEvent);
    on<GoalButtonTapped>(_goalButtonTapped);
    on<SplitButtonTapped>(_splitButtonTapped);
    on<DateOfBirthChosen>(_dateOfBirthChosen);
    on<WeightChosen>(_weightChosen);
    on<HeightChosen>(_heightChosen);
    on<FitnessLevelChosen>(_fitnessLevelChosen);
    on<FinishButtonTapEvent>(_finishButtonTapEvent);
  }

  void _onChooseGenderEvent(
      ChooseGenderEvent event, Emitter<UserConfigState> emit) {
    emit(state.copyWith(isMale: event.isMale));
  }

  void _nextButtonTapEvent(
      NextButtonTapEvent event, Emitter<UserConfigState> emit) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void _finishButtonTapEvent(FinishButtonTapEvent event, Emitter emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMale', state.isMale!);
    await prefs.setStringList('selectedGoalsIndexes',
        state.selectedGoalsIndexes.map((e) => e.toString()).toList());
    await prefs.setStringList('selectedSplitIndexes',
        state.selectedSplitIndexes.map((e) => e.toString()).toList());
    await prefs.setString('dateTime', state.dateTime!.toIso8601String());
    await prefs.setInt('weight', state.weight!);
    await prefs.setInt('height', state.height!);
    await prefs.setDouble('fitPercentage', state.fitPercentage!);
  }

  _goalButtonTapped(GoalButtonTapped event, Emitter<UserConfigState> emit) {
    if (state.selectedGoalsIndexes.contains(event.index)) {
      emit(
        state.copyWith(
            selectedGoalsIndexes: List.from(state.selectedGoalsIndexes)
              ..remove(event.index)),
      );
    } else {
      if (state.selectedGoalsIndexes.length == 3) {
        emit(
          state.copyWith(
            selectedGoalsIndexes: List.from(state.selectedGoalsIndexes)
              ..removeAt(0)
              ..add(event.index),
          ),
        );
      } else {
        emit(
          state.copyWith(
            selectedGoalsIndexes: List.from(state.selectedGoalsIndexes)
              ..add(event.index),
          ),
        );
      }
    }
  }

  _splitButtonTapped(SplitButtonTapped event, Emitter<UserConfigState> emit) {
    if (state.selectedSplitIndexes.contains(event.index)) {
      emit(
        state.copyWith(
          selectedSplitIndexes: List.from(state.selectedSplitIndexes)
            ..remove(event.index),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedSplitIndexes: List.from(state.selectedSplitIndexes)
            ..add(event.index),
        ),
      );
    }
  }

  _dateOfBirthChosen(DateOfBirthChosen event, Emitter<UserConfigState> emit) {
    emit(state.copyWith(dateTime: event.dateTime));
  }

  _weightChosen(WeightChosen event, Emitter<UserConfigState> emit) {
    emit(state.copyWith(weight: event.weight));
  }

  _heightChosen(HeightChosen event, Emitter<UserConfigState> emit) {
    emit(state.copyWith(height: event.height));
  }

  _fitnessLevelChosen(FitnessLevelChosen event, Emitter<UserConfigState> emit) {
    emit(state.copyWith(fitPercentage: event.percentage));
  }
}
