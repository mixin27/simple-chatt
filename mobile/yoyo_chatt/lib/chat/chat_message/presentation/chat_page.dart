import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/chat/chat_list/domain/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/presentation/chat_list_page.dart';

import 'package:yoyo_chatt/chat/chat_list/shared/chat_providers.dart';
import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_dto.dart';
import 'package:yoyo_chatt/chat/chat_message/shared/chat_message_providers.dart';
import 'package:yoyo_chatt/chat/core/utils/chat_helpers.dart';
import 'package:yoyo_chatt/core/providers/core_providers.dart';
import 'package:yoyo_chatt/core/socket/socket_io.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/core/widgets/startup_container.dart';

// final selectedCompareProvider = StateProvider<ChatEntity?>((ref) {
//   return null;
// });

// final typingProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });

// final isTypingProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });

final typingUserProvider = StateProvider.autoDispose<UserEntity?>((ref) {
  return null;
});

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
          ref.read(getChatsNotifierProvider.notifier).getAllChats();

          ref
              .read(messageListProvider.notifier)
              .update((state) => [_.message.toChatMessage, ...chatMessages]);

          SocketIo.instance.emit("new message", _.message.toDto().toJson());
          dLog("Sending message successfully.");
        },
        error: (_) {
          eLog(_.failure.message ?? "Error on sending message.");
        },
      );
    });

    // useEffect(() {
    //   Future.microtask(() {
    //     final chat = ref.watch(selectedChatProvider);
    //     ref.read(selectedCompareProvider.notifier).update((state) => chat);
    //   });

    //   return null;
    // }, []);

    void listenChatChannel(ChatEntity chat) {
      //
      SocketIo.instance.on("message received", (data) {
        if (data != null) {
          final newMessageReceived = ChatMessageDto.fromJson(data).toDomain();
          wLog(newMessageReceived);

          ref.read(messageListProvider.notifier).update(
                (state) => [newMessageReceived.toChatMessage, ...state],
              );
          // final selectedCompare = ref.watch(selectedCompareProvider);
          // if (selectedCompare != null ||
          //     selectedCompare!.id != newMessageReceived.id) {
          //   // TODO: give notification
          // } else {

          // }
        }
      });

      // SocketIo.instance.on("typing", (data) {
      //   ref.read(typingProvider.notifier).update((state) => true);
      //   eLog(data);
      // });

      // SocketIo.instance.on("stop typing", (data) {
      //   ref.read(isTypingProvider.notifier).update((state) => false);
      // });
    }

    void typingHandler(String text) {
      // final socketConnected = ref.watch(isSocketConnectedProvider);
      // eLog("socketConnected: $socketConnected");
      // final typing = ref.watch(typingProvider);
      // eLog("typing: $typing");

      // if (!socketConnected) return;

      // if (!typing) {
      //   ref.read(typingProvider.notifier).update((state) => true);
      //   SocketIo.instance.emit(
      //     "typing",
      //     [
      //       selectedChat.id,
      //       currentUser.toJson(),
      //     ],
      //   );
      // }

      // final lastTypingTime = DateTime.now().microsecondsSinceEpoch;
      // int timerLength = 3000;
      // Timer.periodic(Duration(milliseconds: timerLength), (timer) {
      //   var timeNow = DateTime.now().millisecondsSinceEpoch;
      //   var timeDiff = timeNow - lastTypingTime;
      //   if (timeDiff >= timerLength && typing) {
      //     SocketIo.instance.emit("stop typing", selectedChat.id);
      //     ref.read(typingProvider.notifier).update((state) => false);
      //   }
      // });
    }

    // final typingUser = ref.watch(typingUserProvider);
    // final isTyping = ref.watch(isTypingProvider);

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

          listenChatChannel(selectedChat);
          // socketIo.Socket socket = socketIo.io(Endpoints.socketUrl,
          //     socketIo.OptionBuilder().setTransports(['websocket']).build());

          // socket.emit("setup", [currentUser.toJson()]);
          // socket.on("connected", (data) {
          //   wLog("Socket connected.");
          // });
        },
        onDisposed: () {
          // leaveChatChannel(selectedChat);
        },
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
            inputOptions: InputOptions(
              onTextChange: typingHandler,
            ),
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
