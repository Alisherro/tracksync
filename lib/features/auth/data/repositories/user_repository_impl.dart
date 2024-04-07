import 'package:dartz/dartz.dart';
import 'package:tracksync/core/error/failure.dart';
import 'package:tracksync/features/auth/data/datasources/user_local_datasource.dart';
import 'package:tracksync/features/auth/data/datasources/user_remote_datasource.dart';
import 'package:tracksync/features/auth/domain/entities/user.dart';
import 'package:tracksync/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.localDataSource, this.remoteDataSource);

  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  @override
  Future<Either<Failure, User>> getRemoteUser() async {
    return await remoteDataSource.getUser();
  }

  @override
  Future<Either<Failure, User>> getSavedUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<Either<Failure, bool>> saveUser(User user) async {
    return await localDataSource.saveUser(user);
  }

  @override
  Future<Either<Failure, String>> getSavedToken() async {
    return await localDataSource.getToken();
  }

  @override
  Future<Either<Failure, bool>> saveUserToken(String token) async {
    return await localDataSource.saveToken(token);
  }

  @override
  Future<Either<Failure, bool>> logout() async{
    await remoteDataSource.logout();
    localDataSource.deleteUserInfo();
    return const Right(true);
  }
}
