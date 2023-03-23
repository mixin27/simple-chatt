import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yoyo_chatt/auth/repository/auth_repository.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';

class AppInterceptors extends Interceptor {
  static AppInterceptors? _singleton;

  AppInterceptors._internal();

  factory AppInterceptors() {
    return _singleton ??= AppInterceptors._internal();
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Tries to add Authorization header only if Authorization header
    // not existed
    if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
      final userRepository = AuthRepository(
        secureStorage: const FlutterSecureStorage(),
      );
      final credential = await userRepository.read();

      if (credential != null) {
        options.headers[HttpHeaders.authorizationHeader] =
            'Bearer ${credential.token}';
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Maps custom response
    final responseData = mapResponseData(
      requestOptions: response.requestOptions,
      response: response,
    );

    return handler.resolve(responseData);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Gets custom error message
    final errorMessage = getErrorMessage(err.type, err.response?.statusCode);

    // Maps custom response
    final responseData = mapResponseData(
      requestOptions: err.requestOptions,
      response: err.response,
      customMessage: errorMessage,
      isErrorResponse: true,
    );

    return handler.resolve(responseData);
  }
}

String getErrorMessage(DioErrorType errorType, int? statusCode) {
  String errorMessage = "";
  switch (errorType) {
    case DioErrorType.connectionTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      errorMessage = DioErrorMessage.deadlineExceededException;
      break;
    case DioErrorType.connectionError:
      errorMessage = DioErrorMessage.noInternetConnectionException;
      break;
    case DioErrorType.badResponse:
      switch (statusCode) {
        case 400:
          errorMessage = DioErrorMessage.badRequestException;
          break;
        case 401:
          errorMessage = DioErrorMessage.unauthorizedException;
          break;
        case 404:
          errorMessage = DioErrorMessage.notFoundException;
          break;
        case 409:
          errorMessage = DioErrorMessage.conflictException;
          break;
        case 500:
          errorMessage = DioErrorMessage.internalServerErrorException;
          break;
      }
      break;
    case DioErrorType.cancel:
      errorMessage = DioErrorMessage.userCancelException;
      break;
    case DioErrorType.unknown:
      errorMessage = DioErrorMessage.unexpectedException;
      break;
    case DioErrorType.badCertificate:
      break;
  }

  return errorMessage;
}

/// Custom error messages
class DioErrorMessage {
  static const badRequestException = "Invalid request";
  static const internalServerErrorException =
      "Unknown error occurred, please try again later.";
  static const conflictException = "Conflict occurred";
  static const unauthorizedException = "Access denied";
  static const notFoundException =
      "The requested information could not be found";
  static const unexpectedException = "Unexpected error occurred.";
  static const noInternetConnectionException =
      "No internet connection detected, please try again.";
  static const deadlineExceededException =
      "The connection has timed out, please try again.";
  static const userCancelException = "User cancel the request.";
}

Response<dynamic> mapResponseData({
  Response<dynamic>? response,
  required RequestOptions requestOptions,
  String customMessage = "",
  bool isErrorResponse = false,
}) {
  final bool hasResponseData = response?.data != null;

  Map<String, dynamic>? responseData = response?.data;

  if (hasResponseData) {
    responseData!.addAll({
      "statusCode": response?.statusCode,
      "statusMessage": response?.statusMessage,
    });
  }

  return Response(
    requestOptions: requestOptions,
    data: hasResponseData
        ? responseData
        : AppResponse(
            success: isErrorResponse ? false : true,
            message: customMessage,
            statusCode: response?.statusCode,
            statusMessage: response?.statusMessage,
          ).toJson((value) => null),
  );
}
