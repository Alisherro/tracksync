import 'package:tracksync/data/data_provider/leaderboard_data_provider.dart';
import 'package:tracksync/data/data_provider/user_remote_data_provider.dart';
import 'package:tracksync/data/repositories/user_repository_impl.dart';
import 'package:tracksync/data/repositories/users_data_repository.dart';

import '../data/data_provider/run_result_data_provider.dart';
import '../data/repositories/run_result_data_repository.dart';
import '../domain/use_cases/run_result_use_case.dart';
import '../domain/use_cases/user_use_case.dart';
import '../domain/use_cases/users_use_case.dart';

class AppDependencies {
  static RunResultUseCase provideRunResultUseCase() {
    return RunResultUseCase(RunResultDataRepository(IsarDataProvider()));
  }

  static UsersUseCase provideUsersUseCase() {
    return UsersUseCase(UsersDataRepository(MockUsersDataProvider()));
  }

  static UserUseCase provideUserUseCase() {
    return UserUseCase(UserRepositoryImpl(UserMockDataProvider()));
  }
}
