import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../entities/entities.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Login>> login(LoginParams loginParams);

  Future<Either<Failure, Register>> register(RegisterParams registerParams);
}
