import 'package:flutter/material.dart';

class PendencyListError {
   PendencyListError({required this.errorMessage}) {
    showErrorMessage(errorMessage);
  }

  String errorMessage;

  void showErrorMessage(String message) {
    FlutterError.dumpErrorToConsole(
        FlutterErrorDetails(exception: Exception(message)));
  }
}