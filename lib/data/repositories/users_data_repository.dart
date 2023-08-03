import 'package:smerse/data/data_provider/users_data_provider.dart';
import 'package:smerse/domain/repositories/users_repository.dart';

import '../models/user.dart';

class UsersDataRepository extends UsersRepository {
  UsersDataRepository(this.usersDataProvider);

  final UsersDataProvider usersDataProvider;

  @override
  Future<List<User>> getUsersList(String filter) async {
    return await usersDataProvider.getUsersList(filter);
  }
}
