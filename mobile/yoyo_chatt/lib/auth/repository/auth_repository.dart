import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/models/requests/register_request.dart';
import 'package:yoyo_chatt/auth/models/requests/login_request.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/auth/repository/base_auth_repository.dart';
import 'package:yoyo_chatt/auth/repository/credential_storage.dart';
import 'package:yoyo_chatt/core/http/dio_client.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';

import '../../core/utils/endpoints.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    secureStorage: ref.watch(secureStorageProvider),
  );
});

class AuthRepository implements BaseAuthRepository, CredentialStorage {
  AuthRepository({
    Dio? dioClient,
    required FlutterSecureStorage secureStorage,
  })  : _dioClient = dioClient ??= DioClient().instance,
        _secureStorage = secureStorage;

  final Dio _dioClient;
  final FlutterSecureStorage _secureStorage;

  static const String _key = 'auth_credential';
  Credential? _cachedCredential;

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
    await clear();
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

  @override
  Future<Credential?> read() async {
    if (_cachedCredential != null) return _cachedCredential;

    final result = await _secureStorage.read(key: _key);
    if (result == null) return null;

    try {
      final json = jsonDecode(result);
      return _cachedCredential = Credential.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(Credential credential) {
    _cachedCredential = credential;

    return _secureStorage.write(
      key: _key,
      value: jsonEncode(credential.toJson()),
    );
  }

  @override
  Future<void> clear() {
    _cachedCredential = null;
    return _secureStorage.delete(key: _key);
  }
}
