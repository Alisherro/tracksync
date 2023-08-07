import 'package:tracksync/domain/repositories/user_repository.dart';

import '../data_provider/user_remote_data_provider.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this.userRemoteDataProvider);

  final UserRemoteDataProvider userRemoteDataProvider;

  @override
  Future<String> login(String userName, String password) async {
    return await userRemoteDataProvider.login(userName, password);
  }

  @override
  Future<bool> register(String userName, String email, String password) async {
    return await userRemoteDataProvider.register(userName, email, password);
  }
}
