import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:yoyo_chatt/core/http/app_interceptors.dart';

class DioClient {
  static DioClient? _instance;

  static late Dio _dio;

  DioClient._() {
    _dio = _createDioClient();
  }

  factory DioClient() => _instance ??= DioClient._();

  Dio get instance => _dio;

  Dio _createDioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.0.17:5000",
        receiveTimeout: const Duration(milliseconds: 150000),
        connectTimeout: const Duration(milliseconds: 150000),
        sendTimeout: const Duration(milliseconds: 150000),
        headers: {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
      AppInterceptors(),
    ]);

    return dio;
  }
}
