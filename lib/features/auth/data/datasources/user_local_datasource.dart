import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracksync/features/auth/domain/entities/user.dart';

import '../../../../core/error/failure.dart';

abstract interface class UserLocalDataSource {
  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, bool>> saveUser(User user);

  Future<Either<Failure, String>> getToken();

  Future<Either<Failure, bool>> saveToken(String token);

  Future<Either<Failure, bool>> deleteUserInfo();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<Either<Failure, User>> getUser() async {
    String? jsonString = sharedPreferences.getString('user');
    if (jsonString == null) {
      return const Left(NoDataFailure());
    } else {
      try {
        User user = User.fromJson(jsonDecode(jsonString));
        return Right(user);
      } on Exception {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> saveUser(User user) async {
    bool success =
        await sharedPreferences.setString('user', jsonEncode(user.toMap()));
    if (success) {
      return Right(success);
    } else {
      return const Left(FormatFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    String? token = sharedPreferences.getString('token');

    if (token != null) {
      return Right(token);
    } else {
      return const Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveToken(String token) async {
    bool success = await sharedPreferences.setString('token', token);
    if (success) {
      return Right(success);
    } else {
      return const Left(FormatFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUserInfo() async {
    bool successToken = await sharedPreferences.remove('token');
    bool successUser = await sharedPreferences.remove('user');
    if (successUser && successUser) {
      return const Right(true);
    } else {
      return const Left(CacheFailure());
    }
  }
}
