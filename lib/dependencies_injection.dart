import 'package:get_it/get_it.dart';
import 'package:tracksync/domain/repositories/run_result_repository.dart';
import 'package:tracksync/features/leaderboard/data/repositories/leaderboard_repository_impl.dart';
import 'package:tracksync/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import '../data/data_provider/run_result_data_provider.dart';
import '../data/repositories/run_result_data_repository.dart';
import 'core/api/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_datasrouces.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/pages/login/cubit/auth_cubit.dart';
import 'features/auth/pages/register/cubit/register_cubit.dart';
import 'features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'features/leaderboard/pages/leaderboard/cubit/leaderboard_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerSingleton<DioClient>(DioClient());

  _dataSources();
  _repositories();
  _cubit();

  sl.registerFactory<RunResultRepository>(
      () => RunResultDataRepository(IsarDataProvider()));
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(sl()),
  );
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LeaderboardRemoteDataSource>(
      () => LeaderboardRemoteDataSourceMockImpl());
}

void _cubit() {
  /// Auth
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => LeaderboardCubit(sl()));
}
