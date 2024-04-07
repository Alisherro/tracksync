import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/register.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<Either<Failure, RegisterResponse>> register(
      RegisterParams registerParams);

  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<Either<Failure, RegisterResponse>> register(
    RegisterParams registerParams,
  ) async {
    final response = await _client.postRequest(
      ListAPI.register,
      data: registerParams.toJson(),
      converter: (response) =>
          RegisterResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams) async {
    final response = await _client.postRequest(
      ListAPI.login,
      data: loginParams.toJson(),
      converter: (response) =>
          LoginResponse.fromJson(response as Map<String, dynamic>),
    );
    return response;
  }
}
