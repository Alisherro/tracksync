import 'package:dartz/dartz.dart';
import 'package:tracksync/core/error/failure.dart';
import 'package:tracksync/features/auth/domain/entities/entities.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasrouces.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.authRemoteDataSource);

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async {
    final response = await authRemoteDataSource.login(loginParams);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Register>> register(
      RegisterParams registerParams) async {
    final response = await authRemoteDataSource.register(registerParams);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }
}
