
import 'package:dartz/dartz.dart';
import 'package:tracksync/features/challenges/domain/entities/challenge.dart';

import '../../../../core/error/failure.dart';

abstract interface class ChallengesRepository{
  Future<Either<Failure, List<Challenge>>> getChallenges();

}