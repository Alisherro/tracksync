import 'package:tracksync/data/data_provider/leaderboard_data_provider.dart';
import 'package:tracksync/domain/repositories/users_repository.dart';

import '../models/user.dart';

class UsersDataRepository extends UsersRepository {
  UsersDataRepository(this.usersDataProvider);

  final LeaderboardDataProvider usersDataProvider;

  @override
  Future<List<User>> getUsersList(String filter) async {
    return await usersDataProvider.getUsersList(filter);
  }
}
