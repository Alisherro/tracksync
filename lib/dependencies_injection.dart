import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracksync/features/auth/data/datasources/user_local_datasource.dart';
import 'package:tracksync/features/auth/data/datasources/user_remote_datasource.dart';
import 'package:tracksync/features/auth/data/repositories/user_repository_impl.dart';
import 'package:tracksync/features/challenges/data/datasources/challenges_remote_datasource.dart';
import 'package:tracksync/features/challenges/data/repositories/challenges_repository_impl.dart';
import 'package:tracksync/features/challenges/domain/repositories/challenges_repository.dart';
import 'package:tracksync/features/challenges/presentation/challenges/bloc/challenges_bloc.dart';
import 'package:tracksync/features/leaderboard/data/repositories/leaderboard_repository_impl.dart';
import 'package:tracksync/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:tracksync/features/run/data/datasources/run_result_remote_datasource.dart';

import 'core/api/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_datasrouces.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/presentation/login/cubit/login_cubit.dart';
import 'features/auth/presentation/profile/bloc/user_bloc.dart';
import 'features/auth/presentation/register/cubit/register_cubit.dart';
import 'features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'features/leaderboard/presentation/leaderboard/cubit/leaderboard_cubit.dart';
import 'features/run/data/datasources/run_result_local_datasource.dart';
import 'features/run/data/repositories/run_result_repository_impl.dart';
import 'features/run/domain/entities/run_result.dart';
import 'features/run/domain/repositories/run_result_repository.dart';
import 'features/run/presentation/run_history/cubit/results_list_cubit.dart';
import 'features/run/presentation/running_map/bloc/running_map_bloc.dart';

GetIt sl = GetIt.I;

Future<void> setupLocator() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final Isar isar = await _openDB();

  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerSingleton<Isar>(isar);

  /// Register repositories
  void _repositories() {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<LeaderboardRepository>(
      () => LeaderboardRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<RunResultRepository>(
      () => RunResultRepositoryImpl(sl(), sl()),
    );

    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl(), sl()),
    );

    sl.registerLazySingleton<ChallengesRepository>(
      () => ChallengesRepositoryImpl(sl()),
    );
  }

  /// Register dataSources
  void _dataSources() {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<LeaderboardRemoteDataSource>(
        () => LeaderboardRemoteDataSourceImpl(sl()));

    sl.registerLazySingleton<RunResultLocalDatasource>(
        () => RunResultDatasourceIsar(sl()));

    sl.registerLazySingleton<RunResultRemoteDatasource>(
        () => RunResultRemoteDatasourceImpl(sl()));

    sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(sl()));

    sl.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSourceImpl(sharedPreferences));

    sl.registerLazySingleton<ChallengesRemoteDataSource>(
        () => ChallengesRemoteDataSourceImpl(sl()));
  }

  /// Register cubits/blocs

  void _cubit() {
    sl.registerFactory(() => RegisterCubit(sl()));
    sl.registerFactory(() => LoginCubit(sl()));
    sl.registerFactory(() => LeaderboardCubit(sl()));
    sl.registerFactory(() => ResultsListCubit(sl()));
    sl.registerFactory(() => RunningMapBloc(sl(), sl()));
  }

  void _bloc() {
    sl.registerSingleton<UserBloc>(UserBloc(sl(), sl()));
    sl.registerSingleton<ChallengesBloc>(ChallengesBloc(sl()));
  }

  _dataSources();
  _repositories();
  _cubit();
  _bloc();
}
Future<Isar> _openDB() async {
  if (Isar.instanceNames.isEmpty) {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([RunResultSchema], directory: dir.path);
  }
  return await Future.value(Isar.getInstance());
}
