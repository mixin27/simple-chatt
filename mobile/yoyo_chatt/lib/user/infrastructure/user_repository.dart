import 'package:dartz/dartz.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/user/domain/user_failure.dart';
import 'package:yoyo_chatt/user/infrastructure/user_remote_service.dart';

class UserRepository {
  UserRepository({
    required UserRemoteService userRemoteService,
  }) : _userRemoteService = userRemoteService;

  final UserRemoteService _userRemoteService;

  Future<Either<UserFailure, List<UserEntity>>> getAllUsers() async {
    final response = await _userRemoteService.getUsers();

    if (response.success && response.data != null) {
      return right(response.data!);
    }

    return left(UserFailure.api(response.statusCode, response.message));
  }
}
