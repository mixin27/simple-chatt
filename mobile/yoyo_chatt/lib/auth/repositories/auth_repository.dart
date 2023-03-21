import 'package:dio/dio.dart';
import 'package:yoyo_chatt/auth/models/requests/register_request.dart';
import 'package:yoyo_chatt/auth/models/requests/login_request.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/auth/repositories/base_auth_repository.dart';
import 'package:yoyo_chatt/core/http/dio_client.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';

import '../../core/utils/endpoints.dart';

class AuthRepository implements BaseAuthRepository {
  AuthRepository({
    Dio? dioClient,
  }) : _dioClient = dioClient ??= DioClient().instance;

  final Dio _dioClient;

  @override
  Future<AppResponse<Credential?>> login(LoginRequest request) async {
    final response = await _dioClient.post(
      Endpoints.login,
      data: request.toJson(),
    );

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? Credential.fromJson(json)
          : null,
    );
  }

  @override
  Future<AppResponse<Credential?>> register(RegisterRequest request) async {
    final response = await _dioClient.post(
      Endpoints.register,
      data: request.toJson(),
    );

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? Credential.fromJson(json)
          : null,
    );
  }

  @override
  Future<AppResponse> logout() async {
    // final response = await _dioClient.get(
    //   Endpoints.logout,
    // );

    // return AppResponse.fromJson(
    //   response.data,
    //   (dynamic json) => null,
    // );
    return AppResponse(
      success: true,
      message: "Logout successfully.",
    );
  }
}
