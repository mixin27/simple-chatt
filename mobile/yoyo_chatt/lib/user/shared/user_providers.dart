import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/core/providers/core_providers.dart';
import 'package:yoyo_chatt/user/application/get_users_notifier.dart';
import 'package:yoyo_chatt/user/infrastructure/user_remote_service.dart';
import 'package:yoyo_chatt/user/infrastructure/user_repository.dart';

final userRemoteServiceProvider = Provider<UserRemoteService>((ref) {
  return UserRemoteService();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    userRemoteService: ref.watch(userRemoteServiceProvider),
  );
});

final getUsersNotifierProvider =
    StateNotifierProvider<GetUsersNotifier, GetUsersState>((ref) {
  return GetUsersNotifier(
    userRepository: ref.watch(userRepositoryProvider),
  );
});

final userListProvider = StateProvider<List<UserEntity>>((ref) {
  return ref.watch(getUsersNotifierProvider).maybeWhen(
        orElse: () => [],
        success: (users) {
          final user = ref.watch(currentUserProvider);
          if (user == null) return users;

          List<UserEntity> temps = List.from(users);
          final filterUsers =
              temps.where((element) => element.id != user.id).toList();
          return filterUsers;
        },
      );
});
