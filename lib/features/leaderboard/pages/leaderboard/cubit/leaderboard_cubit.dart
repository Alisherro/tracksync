import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/features/leaderboard/domain/entities/leader.dart';
import 'package:tracksync/features/leaderboard/domain/entities/leaderboard.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/repositories/leaderboard_repository.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit(this.repo) : super(LeaderboardInitial()) {
    initData();
  }

  final LeaderboardRepository repo;
  int leaderboardFilterIndex = 0;

  Future<void> initData() async {
    emit(LeaderboardLoading());
    final response = await repo.getLeaderboard(const LeaderboardParams(''));
    response.fold((l) {
      emit(LeaderboardFailed(l));
    }, (r) {
      emit(LeaderboardSuccess(r));
    });
  }

  Future<void> filterChanged(int index) async {
    emit(LeaderboardLoading());
    leaderboardFilterIndex = index;
    final response = await repo.getLeaderboard(LeaderboardParams('$index'));
    response.fold((l) {
      emit(LeaderboardFailed(l));
    }, (r) {
      emit(LeaderboardSuccess(r));
    });
  }
}
