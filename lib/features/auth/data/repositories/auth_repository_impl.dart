import 'package:dartz/dartz.dart';
import 'package:tracksync/core/error/failure.dart';
import 'package:tracksync/features/auth/domain/entities/entities.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasrouces.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.remote);

  final AuthRemoteDataSource remote;

  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async {
    final response = await remote.login(loginParams);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Register>> register(
      RegisterParams registerParams) async {
    final response = await remote.register(registerParams);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }
}
