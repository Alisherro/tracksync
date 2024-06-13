import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'user_config_event.dart';

part 'user_config_state.dart';

const List goals = [
  'Increase running distance',
  'Improve run times',
  'Consistent daily running',
  'Enhance endurance',
  'Trail running exploration'
];

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {
  final PageController pageController = PageController();
  final UserRepository userRepository;

  UserConfigBloc(this.userRepository) : super(UserConfigStateData()) {
    on<ChooseGenderEvent>(_onChooseGenderEvent);
    on<NextButtonTapEvent>(_nextButtonTapEvent);
    on<GoalButtonTapped>(_goalButtonTapped);
    on<DateOfBirthChosen>(_dateOfBirthChosen);
    on<WeightChosen>(_weightChosen);
    on<HeightChosen>(_heightChosen);
    on<FitnessLevelChosen>(_fitnessLevelChosen);
    on<FinishButtonTapEvent>(_finishButtonTapEvent);
  }

  void _onChooseGenderEvent(
      ChooseGenderEvent event, Emitter<UserConfigState> emit) {
    emit((state as UserConfigStateData).copyWith(isMale: event.isMale));
  }

  void _nextButtonTapEvent(
      NextButtonTapEvent event, Emitter<UserConfigState> emit) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void _finishButtonTapEvent(FinishButtonTapEvent event, Emitter emit) async {
    if ((state is UserConfigStateData)&&(state as UserConfigStateData).isFinished) {
      final curState=(state as UserConfigStateData);
      emit(UserConfigStateLoading());
      final res = await userRepository
          .configureInformation(curState.toMap());
      res.fold(
        (l) {
          emit(UserConfigStateFailed('Unexpected Error'));
          emit(curState);
        },
        (r) {
          if(r!=null){
            emit(UserConfigStateSuccess(r));
          }
        },
      );
    }
  }

  _goalButtonTapped(GoalButtonTapped event, Emitter<UserConfigState> emit) {
    if ((state as UserConfigStateData)
        .selectedGoalsIndexes
        .contains(event.index)) {
      emit(
        (state as UserConfigStateData).copyWith(
            selectedGoalsIndexes:
                List.from((state as UserConfigStateData).selectedGoalsIndexes)
                  ..remove(event.index)),
      );
    } else {
      if ((state as UserConfigStateData).selectedGoalsIndexes.length == 3) {
        emit(
          (state as UserConfigStateData).copyWith(
            selectedGoalsIndexes:
                List.from((state as UserConfigStateData).selectedGoalsIndexes)
                  ..removeAt(0)
                  ..add(event.index),
          ),
        );
      } else {
        emit(
          (state as UserConfigStateData).copyWith(
            selectedGoalsIndexes:
                List.from((state as UserConfigStateData).selectedGoalsIndexes)
                  ..add(event.index),
          ),
        );
      }
    }
  }

  _dateOfBirthChosen(DateOfBirthChosen event, Emitter<UserConfigState> emit) {
    emit((state as UserConfigStateData).copyWith(dateTime: event.dateTime));
  }

  _weightChosen(WeightChosen event, Emitter<UserConfigState> emit) {
    emit((state as UserConfigStateData).copyWith(weight: event.weight));
  }

  _heightChosen(HeightChosen event, Emitter<UserConfigState> emit) {
    emit((state as UserConfigStateData).copyWith(height: event.height));
  }

  _fitnessLevelChosen(FitnessLevelChosen event, Emitter<UserConfigState> emit) {
    emit((state as UserConfigStateData)
        .copyWith(fitPercentage: event.percentage));
  }
}
