import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/chat/chat_message/application/create_message_notifier.dart';
import 'package:yoyo_chatt/chat/chat_message/application/get_messages_notifier.dart';
import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_remote_service.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_repository.dart';

final chatMessageRemoteServiceProvider =
    Provider<ChatMessageRemoteService>((ref) {
  return ChatMessageRemoteService();
});

final chatMessageRepositoryProvider = Provider<ChatMessageRepository>((ref) {
  return ChatMessageRepository(
    chatMessageRemoteService: ref.watch(chatMessageRemoteServiceProvider),
  );
});

final getChatMessagesNotifierProvider =
    StateNotifierProvider.autoDispose<GetMessagesNotifier, GetMessagesState>(
        (ref) {
  return GetMessagesNotifier(
    chatMessageRepository: ref.watch(chatMessageRepositoryProvider),
  );
});

final createMessageNotifierProvider = StateNotifierProvider.autoDispose<
    CreateMessageNotifier, CreateMessageState>((ref) {
  return CreateMessageNotifier(
    chatMessageRepository: ref.watch(chatMessageRepositoryProvider),
  );
});

final messageListProvider = StateProvider<List<ChatMessageEntity>>((ref) {
  return [];
});
