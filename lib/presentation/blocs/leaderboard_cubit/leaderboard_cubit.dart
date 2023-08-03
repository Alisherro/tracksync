import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracksync/domain/use_cases/users_use_case.dart';

import '../../../constants.dart';
import '../../../data/models/user.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit(this.useCase) : super(LeaderboardInitial());
  final UsersUseCase useCase;

  Future<void> initData() async {
    List<User> users = await useCase.getUsers('');
    emit(LeaderboardLoaded(users));
  }

  Future<void> filterChanged(int index) async {
    List<User> users = await useCase.getUsers(leaderboardFilter[index]);

    emit(LeaderboardLoaded(users, index));
  }
}
