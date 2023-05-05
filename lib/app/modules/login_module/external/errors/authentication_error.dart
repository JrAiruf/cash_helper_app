class AuthenticationError implements Exception {
  AuthenticationError({required this.message});
  final String message;
}
