import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/challenge.dart';
import '../../../domain/repositories/challenges_repository.dart';

part 'challenges_event.dart';

part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  final ChallengesRepository repository;

  ChallengesBloc(this.repository) : super(ChallengesLoading()) {
    on<ChallengesEvent>(
      (event, emit) async {
        switch (event) {
          case ChallengesFetchEvent():
            await onFetch(emit);
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
}
