abstract class Failure implements Exception {
  final String message;
  final StackTrace stackTrace;

  const Failure(this.message, this.stackTrace);
}

class DatasourceFailure extends Failure {
  DatasourceFailure({required String message, required StackTrace stackTrace})
      : super(message, stackTrace);
}

class DomainFailure extends Failure {
  DomainFailure({required String message, required StackTrace stackTrace})
      : super(message, stackTrace);
}
