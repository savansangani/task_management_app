import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;

class _NetworkService {
  final Dio _dio = Dio();

  _NetworkService() {
    _dio.options.baseUrl = 'https://hushed-foggy-dollar.glitch.me/';
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.get(url, queryParameters: queryParameters);

    return response;
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      _dio.options.headers['Accept'] =
          options?.contentType ?? 'application/json';

      if (data != null && options?.contentType == 'multipart/form-data') {
        FormData formData = FormData.fromMap(data);
        var response = await _dio.post(url, data: formData, options: options);
        return response;
      }

      return await _dio.post(url, data: data, options: options);
    } catch (e) {
      if (e is DioException) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: e.response?.data['message'] ?? "Something went wrong",
            backgroundColor: Colors.red,
            duration: Duration(seconds: 7),
          ),
        );
      }
      rethrow;
    }
  }
}

var sendRequest = _NetworkService();
