import 'package:dio/dio.dart';
import 'package:yoyo_chatt/core/http/dio_client.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/core/utils/endpoints.dart';
import 'package:yoyo_chatt/user/repositories/base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  UserRepository({
    Dio? dioClient,
  }) : _dioClient = dioClient ?? DioClient().instance;

  final Dio _dioClient;

  @override
  Future<AppResponse<List<UserEntity>>> getUsers() async {
    final response = await _dioClient.get(Endpoints.user);

    return AppResponse<List<UserEntity>>.fromJson(
      response.data,
      (dynamic json) {
        if (response.data['success'] && json != null) {
          return (json as List<dynamic>)
              .map((e) => UserEntity.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }
}
