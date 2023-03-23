import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:yoyo_chatt/chat/chat_list/shared/chat_providers.dart';
import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';
import 'package:yoyo_chatt/chat/chat_message/shared/chat_message_providers.dart';
import 'package:yoyo_chatt/chat/core/utils/chat_helpers.dart';
import 'package:yoyo_chatt/core/providers/core_providers.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/core/widgets/startup_container.dart';

@RoutePage()
class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser == null) return const SizedBox();

    final selectedChat = ref.watch(selectedChatProvider);
    if (selectedChat == null) return const SizedBox();

    final chatMessages = ref.watch(messageListProvider);

    ref.listen(createMessageNotifierProvider, (previous, next) {
      next.maybeMap(
        orElse: () {},
        success: (_) {
          ref
              .read(messageListProvider.notifier)
              .update((state) => [_.message.toChatMessage, ...state]);

          ref.read(getChatsNotifierProvider.notifier).getAllChats();

          dLog("Sending message successfully.");
        },
        error: (_) {
          eLog(_.failure.message ?? "Error on sending message.");
        },
      );
    });

    return WillPopScope(
      onWillPop: () async {
        ref.read(selectedChatProvider.notifier).update((state) => null);
        ref.read(messageListProvider.notifier).update((state) => []);
        return true;
      },
      child: StartUpContainer(
        onInit: () {
          ref
              .read(getChatMessagesNotifierProvider.notifier)
              .getAllMessages(chatId: selectedChat.id);
        },
        onDisposed: () {},
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              selectedChat.isGroupChat
                  ? selectedChat.name
                  : ChatHelpers.getSender(currentUser, selectedChat.users),
            ),
          ),
          body: DashChat(
            // typingUsers: [currentUser.toChatUser],
            currentUser: currentUser.toChatUser,
            onSend: (ChatMessage chatMessage) {
              wLog(chatMessage.toJson());

              ref.read(createMessageNotifierProvider.notifier).sendMessage(
                    content: chatMessage.text,
                    chatId: selectedChat.id,
                  );
            },
            messages: chatMessages,
          ),
        ),
      ),
    );
  }
}
