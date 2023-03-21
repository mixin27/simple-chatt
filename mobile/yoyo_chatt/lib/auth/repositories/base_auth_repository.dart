import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';

import '../models/requests/login_request.dart';
import '../models/requests/register_request.dart';

abstract class BaseAuthRepository {
  Future<AppResponse<Credential?>> register(RegisterRequest request);

  Future<AppResponse<Credential?>> login(LoginRequest request);

  Future<AppResponse> logout();
}
