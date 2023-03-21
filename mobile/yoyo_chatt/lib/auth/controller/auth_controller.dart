import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/models/auth_failure.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/auth/models/requests/login_request.dart';
import 'package:yoyo_chatt/auth/models/requests/register_request.dart';
import 'package:yoyo_chatt/auth/repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(
    authRepository: ref.watch(authRepositoryProvider),
  );
});

class AuthController {
  AuthController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<AuthFailure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _authRepository.login(
      LoginRequest(email: email, password: password),
    );

    if (response.success) {
      if (response.data != null) {
        await _authRepository.save(response.data!);

        return right(response.data!.user);
      }
    }

    return left(AuthFailure.server(response.message));
  }

  Future<Either<AuthFailure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _authRepository.register(
      RegisterRequest(name: name, email: email, password: password),
    );

    if (response.success) {
      if (response.data != null) {
        await _authRepository.save(response.data!);

        return right(response.data!.user);
      }
    }

    return left(AuthFailure.server(response.message));
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    final response = await _authRepository.logout();

    if (response.success) {
      return right(unit);
    }

    return left(const AuthFailure.storage());
  }

  Future<UserEntity?> getUserData() async {
    final credential = await _authRepository.read();
    return credential?.user;
  }
}
