import 'package:flutter/material.dart';

class RemovePaymentMethodError implements Exception {
  RemovePaymentMethodError({required this.errorMessage}) {
    showErrorMessage(errorMessage);
  }

  String errorMessage;

  void showErrorMessage(String message) {
    FlutterError.dumpErrorToConsole(
        FlutterErrorDetails(exception: Exception(message)));
  }
}