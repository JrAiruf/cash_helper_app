import 'package:flutter/material.dart';

class PaymentMethodsListUnnavailable implements Exception {
  PaymentMethodsListUnnavailable({required this.errorMessage}) {
    showErrorMessage(errorMessage);
  }

  String errorMessage;

  void showErrorMessage(String message) {
    FlutterError.dumpErrorToConsole(
        FlutterErrorDetails(exception: Exception(message)));
  }
}
