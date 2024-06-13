import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/profile/bloc/user_bloc.dart';
import '../../../domain/entities/challenge.dart';
import '../../../domain/repositories/challenges_repository.dart';

part 'challenges_event.dart';

part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  final ChallengesRepository repository;
  final UserBloc userBloc;

  ChallengesBloc(this.repository, this.userBloc) : super(ChallengesLoading()) {
    on<ChallengesEvent>(
      (event, emit) async {
        switch (event) {
          case ChallengesFetchEvent():
            await onFetch(emit);
          case CheckChallenges():
            await onCheckChallenges(emit);
        }
      },
    );
  }

  Future<void> onFetch(Emitter emitter) async {
    emitter(ChallengesLoading());
    final response = await repository.getChallenges();
    response.fold(
      (l) => emitter(ChallengesError()),
      (r) => emitter(ChallengesLoaded(r)),
    );
  }

  Future<void> onCheckChallenges(Emitter emitter) async {
    final response = await repository.checkChallenges();
    response.fold((l) {
      userBloc.add(const UserGetUpdate());
    }, (r) {
      if (r ?? false) {
        userBloc.add(const UserGetUpdate());
        emitter(SChallengeSuccess());
        add(ChallengesFetchEvent());
      }
    });
  }
}
