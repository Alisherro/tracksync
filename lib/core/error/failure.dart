abstract class Failure {
  final String? message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message]);

  @override
  bool operator ==(Object other) =>
      other is ServerFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

class NoDataFailure extends Failure {
  const NoDataFailure([super.message]);

  @override
  bool operator ==(Object other) => other is NoDataFailure;

  @override
  int get hashCode => 0;
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);

  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}

class FormatFailure extends Failure {
  const FormatFailure([super.message]);

  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}

class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure([super.message]);

  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message]);

  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}
