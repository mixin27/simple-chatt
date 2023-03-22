import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/chat/chat_list/shared/chat_providers.dart';
import 'package:yoyo_chatt/chat/core/utils/chat_helpers.dart';
import 'package:yoyo_chatt/core/providers/core_providers.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/core/widgets/startup_container.dart';
import 'package:yoyo_chatt/user/shared/user_providers.dart';

@RoutePage()
class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser == null) return const SizedBox();

    final selectedChat = ref.watch(selectedChatProvider);

    return StartUpContainer(
      onInit: () {
        // chatBloc.add(const GetChatMessage());
      },
      onDisposed: () {
        // chatBloc.add(const ChatReset());
        // chatBloc.add(const ChatStarted());
      },
      child: Scaffold(
        appBar: AppBar(
          title: selectedChat != null
              ? Text(
                  selectedChat.isGroupChat
                      ? selectedChat.name
                      : ChatHelpers.getSender(currentUser, selectedChat.users),
                )
              : const Text("Chat"),
        ),
      ),
    );
  }
}
