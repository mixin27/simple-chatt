import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';

abstract class BaseUserRepository {
  Future<AppResponse<List<UserEntity>>> getUsers();
}
