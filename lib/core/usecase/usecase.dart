import 'package:dartz/dartz.dart';
import 'package:tracksync/core/core.dart';

abstract interface class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

class NoParams {}
