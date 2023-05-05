abstract class OperationError implements Exception {}

class OppeningCashError extends OperationError {
  OppeningCashError({required this.errorMessage});
  final String errorMessage;
}
