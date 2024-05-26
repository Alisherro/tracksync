import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/features/leaderboard/domain/entities/leaderboard.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/repositories/leaderboard_repository.dart';

part 'leaderboard_state.dart';

enum TimePeriod { day, week, month, all }


class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepository repo;
  LeaderboardCubit(this.repo) : super(LeaderboardInitial()) {
    initData();
  }
  List<TimePeriod> tabs=[
    TimePeriod.day,
    TimePeriod.week,
    TimePeriod.all,
  ];
  int leaderboardFilterIndex = 0;

  Future<void> initData() async {
    emit(LeaderboardLoading());
    final response = await repo.getLeaderboard( LeaderboardParams(tabs[0].name));
    response.fold((l) {
      emit(LeaderboardFailed(l));
    }, (r) {
      emit(LeaderboardSuccess(r));
    });
  }

  Future<void> filterChanged(int index) async {
    emit(LeaderboardLoading());
    leaderboardFilterIndex = index;
    final String query = tabs[leaderboardFilterIndex].name;
    final response = await repo.getLeaderboard(LeaderboardParams(query));
    response.fold((l) {
      emit(LeaderboardFailed(l));
    }, (r) {
      emit(LeaderboardSuccess(r));
    });
  }
}

