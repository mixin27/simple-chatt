import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/chat/chat_list/application/create_or_access_chat_notifier.dart';
import 'package:yoyo_chatt/chat/chat_list/application/create_or_access_group_chat_notifier.dart';
import 'package:yoyo_chatt/chat/chat_list/application/get_chats_notifier.dart';
import 'package:yoyo_chatt/chat/chat_list/domain/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_remote_service.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_repository.dart';

final chatRemoteServiceProvider = Provider<ChatRemoteService>((ref) {
  return ChatRemoteService();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
    chatRemoteService: ref.watch(chatRemoteServiceProvider),
  );
});

final getChatsNotifierProvider =
    StateNotifierProvider.autoDispose<GetChatsNotifier, GetChatsState>((ref) {
  return GetChatsNotifier(
    chatRepository: ref.watch(chatRepositoryProvider),
  );
});

final createOrAccessChatProvider = StateNotifierProvider.autoDispose<
    CreateOrAccessChatNotifier, CreateOrAccessChatState>((ref) {
  return CreateOrAccessChatNotifier(
    chatRepository: ref.watch(chatRepositoryProvider),
  );
});

final createOrAccessGroupChatProvider = StateNotifierProvider.autoDispose<
    CreateOrAccessGroupChatNotifier, CreateOrAccessGroupChatState>((ref) {
  return CreateOrAccessGroupChatNotifier(
    chatRepository: ref.watch(chatRepositoryProvider),
  );
});

final selectedUserIdListProvider = StateProvider<List<String>>((ref) {
  return [];
});

final selectedUsersListProvider = StateProvider<List<UserEntity>>((ref) {
  return [];
});

final selectedChatProvider = StateProvider<ChatEntity?>((ref) {
  return null;
});

final selectedChatUserProvider = StateProvider<UserEntity?>((ref) {
  return null;
});
