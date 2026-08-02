sealed class Failure {
  const Failure({required this.message});

  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, this.statusCode});

  final int? statusCode;
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}
