abstract class DioServiceErrors implements Exception {}

class BadRequestError extends DioServiceErrors {
  BadRequestError({required this.message});
  final String message;
}
class UnknowError extends DioServiceErrors {
  UnknowError({required this.message});
  final String message;
}
