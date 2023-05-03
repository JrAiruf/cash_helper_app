import 'package:flutter/cupertino.dart';

abstract class EnterpriseDatabaseErrors implements Exception {}

class CreateAccountError extends EnterpriseDatabaseErrors {
  CreateAccountError({required this.message});
  final String message;
}

class EnterpriseAccountNotFoundError extends EnterpriseDatabaseErrors {
  EnterpriseAccountNotFoundError({required this.message}) {
    showErrorLog(message);
  }
  final String message;
  void showErrorLog(String message) {
    FlutterError.presentError(FlutterErrorDetails(exception: message));
  }
}
