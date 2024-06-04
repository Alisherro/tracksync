import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tracksync/core/error/failure.dart';
import 'package:tracksync/features/auth/data/datasources/user_local_datasource.dart';
import 'package:tracksync/features/auth/data/datasources/user_remote_datasource.dart';
import 'package:tracksync/features/auth/domain/entities/user.dart';
import 'package:tracksync/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.local, this.remote);

  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  @override
  Future<Either<Failure, User>> getRemoteUser() async {
    return await remote.getUser();
  }

  @override
  Future<Either<Failure, User>> getSavedUser() async {
    return await local.getUser();
  }

  @override
  Future<Either<Failure, bool>> saveUser(User user) async {
    return await local.saveUser(user);
  }

  @override
  Future<Either<Failure, String>> getSavedToken() async {
    return await local.getToken();
  }

  @override
  Future<Either<Failure, bool>> saveUserToken(String token) async {
    return await local.saveToken(token);
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    await remote.logout();
    local.deleteUserInfo();
    return const Right(true);
  }

  @override
  Future<Either<Failure, User?>> changeProfilePicture(
      String path, String name) async {
    return await remote.updateUser(FormData.fromMap(
      {
        "profile_picture": await MultipartFile.fromFile(path,filename: name),
        "_method":"PATCH"
      },
    ));
  }
}
