import 'package:get_it/get_it.dart';
import 'package:tracksync/data/data_provider/leaderboard_data_provider.dart';
import 'package:tracksync/data/data_provider/user_remote_data_provider.dart';
import 'package:tracksync/data/repositories/user_repository_impl.dart';
import 'package:tracksync/data/repositories/users_data_repository.dart';
import 'package:tracksync/domain/repositories/run_result_repository.dart';
import 'package:tracksync/domain/repositories/users_repository.dart';

import '../data/data_provider/run_result_data_provider.dart';
import '../data/repositories/run_result_data_repository.dart';
import '../domain/repositories/user_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerFactory<RunResultRepository>(
      () => RunResultDataRepository(IsarDataProvider()));
  locator.registerFactory<UsersRepository>(
      () => UsersDataRepository(MockUsersDataProvider()));
  locator.registerFactory<UserRepository>(
      () => UserRepositoryImpl(UserMockDataProvider()));
}