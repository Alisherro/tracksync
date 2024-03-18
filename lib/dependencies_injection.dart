import 'package:get_it/get_it.dart';
import 'package:tracksync/features/leaderboard/data/repositories/leaderboard_repository_impl.dart';
import 'package:tracksync/features/leaderboard/domain/repositories/leaderboard_repository.dart';

import 'core/api/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_datasrouces.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/login/cubit/auth_cubit.dart';
import 'features/auth/presentation/register/cubit/register_cubit.dart';
import 'features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'features/leaderboard/presentation/leaderboard/cubit/leaderboard_cubit.dart';
import 'features/run/data/datasources/run_result_local_datasource.dart';
import 'features/run/data/repositories/run_result_data_repository.dart';
import 'features/run/domain/repositories/run_result_repository.dart';
import 'features/run/presentation/running_map/bloc/running_map_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerSingleton<DioClient>(DioClient());

  _dataSources();
  _repositories();
  _cubit();
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<RunResultRepository>(
    () => RunResultRepositoryImpl(sl()),
  );
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LeaderboardRemoteDataSource>(
      () => LeaderboardRemoteDataSourceMockImpl());

  sl.registerLazySingleton<RunResultDatasource>(
      () => RunResultDatasourceIsar());
}

/// Register cubits/blocs

void _cubit() {
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => LeaderboardCubit(sl()));
  sl.registerFactory(() => RunningMapBloc(sl()));
}
