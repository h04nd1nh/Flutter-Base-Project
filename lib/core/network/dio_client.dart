import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../flavors.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio();
    _setupInterceptors();
  }

  Dio get client => _dio;

  void _setupInterceptors() {
    _dio.options = BaseOptions(
      baseUrl: F.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add pretty logger only in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    // Add auth interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          // final token = await _getAuthToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          handler.next(options);
        },
        onError: (error, handler) {
          // Handle global errors here
          handler.next(error);
        },
      ),
    );
  }

  // Future<String?> _getAuthToken() async {
  //   // Get token from secure storage
  //   return null;
  // }
}
