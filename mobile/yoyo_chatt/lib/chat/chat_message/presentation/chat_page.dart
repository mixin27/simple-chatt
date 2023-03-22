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

    final messageState = ref.watch(getChatMessagesNotifierProvider);

    ref.listen(getChatMessagesNotifierProvider, (previous, next) {
      next.maybeMap(
        orElse: () {},
        success: (_) {
          ref.read(messageListProvider.notifier).update((state) => _.messages);
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
            currentUser: currentUser.toChatUser,
            onSend: (ChatMessage chatMessage) {
              wLog(chatMessage.toJson());
            },
            messages: messageState.map(
              initial: (_) => [],
              loading: (_) => [],
              empty: (_) => [],
              success: (_) => _.messages.uiChatMessages,
              error: (_) => [],
            ),
          ),
        ),
      ),
    );
  }
}
