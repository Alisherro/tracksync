import 'package:dartz/dartz.dart';

import '../../../../core/api/dio_client.dart';
import '../../../../core/api/list_api.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';

abstract interface class UserRemoteDataSource {
  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, String?>> logout();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient _client;

  UserRemoteDataSourceImpl(this._client);

  @override
  Future<Either<Failure, User>> getUser() async {
    final response = await _client.getRequest(
      ListAPI.user,
      converter: (response) => User.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  Future<Either<Failure, String?>> logout() async {
    final response = await _client.postRequest<String>(
      ListAPI.logout,
      converter: (json)=>json['message'],
    );

    return response;
  }
}
