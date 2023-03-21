import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yoyo_chatt/auth/bloc/auth_bloc.dart';
import 'package:yoyo_chatt/auth/models/requests/login_request.dart';
import 'package:yoyo_chatt/auth/models/requests/register_request.dart';
import 'package:yoyo_chatt/auth/repositories/auth_repository.dart';

part 'guest_state.dart';
part 'guest_cubit.freezed.dart';

class GuestCubit extends Cubit<GuestState> {
  GuestCubit({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authRepository = authRepository,
        _authBloc = authBloc,
        super(const GuestState.initial());

  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _authRepository.login(
      LoginRequest(email: email, password: password),
    );

    if (response.success) {
      _authBloc.add(
        Authenticated(
          isAuthenticated: true,
          token: response.data!.token,
          user: response.data!.user,
        ),
      );
      return null;
    }

    return response.message;
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _authRepository.register(
      RegisterRequest(name: name, email: email, password: password),
    );

    if (response.success) {
      _authBloc.add(
        Authenticated(
          isAuthenticated: true,
          token: response.data!.token,
          user: response.data!.user,
        ),
      );

      return null;
    }

    return response.message;
  }

  Future<void> signOut() async {
    _authRepository.logout();
    _authBloc.add(
      const AuthEvent.authenticate(
        isAuthenticated: false,
        user: null,
        token: null,
      ),
    );
  }
}
