import 'package:dio/dio.dart';

class DioHandler {
  static final DioHandler _instance = DioHandler._internal();
  factory DioHandler() => _instance;

  late Dio dio;

  DioHandler._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }
}
