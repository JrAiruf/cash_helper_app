import 'package:flutter/material.dart';

class OperatorsUnavailable implements Exception {
  OperatorsUnavailable({required this.message}) {
    showErrorLog(message);
  }
  final String message;
  void showErrorLog(String message) {
    FlutterError.presentError(FlutterErrorDetails(exception: message));
  }

  String get errorMessage => message;
}

