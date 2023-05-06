import 'package:flutter/material.dart';

class OperatorNotFound implements Exception {
  OperatorNotFound({required this.message}) {
    showErrorLog(message);
  }
  final String message;
  void showErrorLog(String message) {
    FlutterError.presentError(FlutterErrorDetails(exception: message));
  }
}
