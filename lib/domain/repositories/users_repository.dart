import '../../data/models/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsersList(String filter);
}
