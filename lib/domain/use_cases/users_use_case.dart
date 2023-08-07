import 'package:tracksync/domain/repositories/users_repository.dart';

import '../../data/models/user.dart';

class UsersUseCase {
  UsersUseCase(this.usersRepository);

  final UsersRepository usersRepository;

  Future<List<User>> getUsers(String filter) async {
    return await usersRepository.getUsersList(filter);
  }
}
