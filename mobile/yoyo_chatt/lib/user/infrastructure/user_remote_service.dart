import 'package:dio/dio.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/core/http/dio_client.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';
import 'package:yoyo_chatt/core/utils/endpoints.dart';

class UserRemoteService {
  UserRemoteService({
    Dio? dioClient,
  }) : _dioClient = dioClient ??= DioClient().instance;

  final Dio _dioClient;

  Future<AppResponse<List<UserEntity>>> getUsers() async {
    final response = await _dioClient.get(Endpoints.user);

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? (json as List<dynamic>).map((e) => UserEntity.fromJson(e)).toList()
          : [],
    );
  }
}
