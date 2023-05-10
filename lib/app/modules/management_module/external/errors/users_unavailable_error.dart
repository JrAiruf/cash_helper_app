import 'package:flutter/material.dart';

class UsersUnavailableError implements Exception {
  UsersUnavailableError({required this.errorMessage}) {
    showErrorMessage(errorMessage);
  }

  String errorMessage;

  void showErrorMessage(String message) {
    FlutterError.dumpErrorToConsole(
        FlutterErrorDetails(exception: Exception(message)));
  }
}
