import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../entities/user.dart';

abstract interface class UserRepository {
  Future<Either<Failure, User>> getSavedUser();

  Future<Either<Failure, bool>> saveUser(User user);

  Future<Either<Failure, User>> getRemoteUser();

  Future<Either<Failure, String>> getSavedToken();

  Future<Either<Failure, bool>> saveUserToken(String token);

  Future<Either<Failure,bool>> logout();
}
