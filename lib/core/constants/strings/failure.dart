class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super("Server error occurred.");
}

class NotFoundFailure extends Failure {
  NotFoundFailure() : super("Requested resource was not found.");
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super("Network error occurred. Please check your internet connection.");
}
