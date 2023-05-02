abstract class EnterpriseDatabaseErrors implements Exception {}

class CreateAccountError extends EnterpriseDatabaseErrors {
  CreateAccountError({required this.message});
  final String message;
}
