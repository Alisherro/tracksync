import 'package:smerse/domain/repositories/users_repository.dart';

import '../../data/models/user.dart';

class UsersUseCase {
  UsersUseCase(this.usersRepository);

  final UsersRepository usersRepository;

  Future<List<User>> getUsers(String filter) async {
    print(filter);
    return await usersRepository.getUsersList(filter);
  }
}
