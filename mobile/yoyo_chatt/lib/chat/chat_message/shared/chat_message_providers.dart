import 'package:dash_chat_2/dash_chat_2.dart';
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
    StateNotifierProvider<GetMessagesNotifier, GetMessagesState>((ref) {
  return GetMessagesNotifier(
    chatMessageRepository: ref.watch(chatMessageRepositoryProvider),
  );
});

final createMessageNotifierProvider =
    StateNotifierProvider<CreateMessageNotifier, CreateMessageState>((ref) {
  return CreateMessageNotifier(
    chatMessageRepository: ref.watch(chatMessageRepositoryProvider),
  );
});

final messageListProvider = StateProvider<List<ChatMessage>>((ref) {
  return ref.watch(getChatMessagesNotifierProvider).maybeWhen(
        orElse: () => [],
        success: (messages) => messages.uiChatMessages.reversed.toList(),
      );
});
