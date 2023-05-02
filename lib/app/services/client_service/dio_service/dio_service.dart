import 'dart:convert';

import 'package:cash_helper_app/app/services/client_service/client_service/cliente_service.dart';
import 'package:cash_helper_app/app/services/client_service/dio_service/errors/dio_service_errors.dart';
import 'package:dio/dio.dart';

class DioService implements CLientService {
  DioService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> post(
      {String? url,
      Map<String, dynamic>? requestBody,
      String? statusMessage,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(url ?? "", data: requestBody);
      return response.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw BadRequestError(message: e.message ?? "");
      } else {
        throw UnknowError(message: e.message ?? "");
      }
    }
  }

  @override
  Future put() {
    // TODO: implement put
    throw UnimplementedError();
  }
}
