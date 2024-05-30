abstract class Failure {
  final String message;

  Failure(this.message);
}

class SomeError extends Failure {
  SomeError(super.message);
}