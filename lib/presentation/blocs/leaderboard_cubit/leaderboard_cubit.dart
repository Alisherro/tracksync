import 'package:bloc/bloc.dart';

import '../../../config/app_dependencies.dart';
import '../../../config/constants.dart';
import '../../../data/models/user.dart';
import '../../../domain/repositories/users_repository.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardInitial());
  UsersRepository get repo => locator<UsersRepository>();

  Future<void> initData() async {
    List<User> users = await repo.getUsersList('');
    emit(LeaderboardLoaded(users));
  }

  Future<void> filterChanged(int index) async {
    List<User> users = await repo.getUsersList(leaderboardFilter[index]);

    emit(LeaderboardLoaded(users, index));
  }
}
