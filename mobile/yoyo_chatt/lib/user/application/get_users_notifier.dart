import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/user/domain/user_failure.dart';
import 'package:yoyo_chatt/user/infrastructure/user_repository.dart';

part 'get_users_notifier.freezed.dart';

@freezed
class GetUsersState with _$GetUsersState {
  const factory GetUsersState.initial() = _Initial;
  const factory GetUsersState.loading() = _Loading;
  const factory GetUsersState.empty() = _Empty;
  const factory GetUsersState.success(List<UserEntity> users) = _Success;
  const factory GetUsersState.error(UserFailure failure) = _Error;
}

class GetUsersNotifier extends StateNotifier<GetUsersState> {
  GetUsersNotifier({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const GetUsersState.initial());

  final UserRepository _userRepository;

  Future<void> getAllUsers() async {
    state = const GetUsersState.loading();

    final fos = await _userRepository.getAllUsers();

    state = fos.fold(
      (l) => GetUsersState.error(l),
      (r) => r.isEmpty ? const GetUsersState.empty() : GetUsersState.success(r),
    );
  }
}
