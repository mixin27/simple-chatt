import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_page/search_page.dart';
import 'package:yoyo_chatt/auth/controller/auth_controller.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/chat/chat_list/domain/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/shared/chat_providers.dart';
import 'package:yoyo_chatt/chat/core/utils/chat_helpers.dart';
import 'package:yoyo_chatt/core/providers/core_providers.dart';
import 'package:yoyo_chatt/core/socket/socket_io.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/core/widgets/startup_container.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';
import 'package:yoyo_chatt/user/shared/user_providers.dart';

final isSocketConnectedProvider = StateProvider<bool>((ref) {
  return false;
});

@RoutePage()
class ChatListPage extends HookConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsState = ref.watch(getChatsNotifierProvider);
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser == null) return const SizedBox();

    ref.listen(createOrAccessChatProvider, (previous, next) {
      next.maybeMap(
        orElse: () {},
        loading: (_) {
          dLog("Creating or accessing chat...");
        },
        success: (_) {
          ref.read(selectedChatProvider.notifier).update((state) => _.chat);
          context.router.push(const ChatRoute());
        },
        error: (_) {
          eLog(_.failure.message ?? "Unknown error occurred.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  _.failure.message ?? "Error on creating or accessing chat."),
            ),
          );
        },
      );
    });

    return StartUpContainer(
      onInit: () {
        ref.read(getChatsNotifierProvider.notifier).getAllChats();
        ref.read(getUsersNotifierProvider.notifier).getAllUsers();

        SocketIo.init();
        SocketIo.instance.emit("setup", currentUser.toJson());
        SocketIo.instance.on(
          "connected",
          (data) {
            wLog("Socket connected");
            ref
                .read(isSocketConnectedProvider.notifier)
                .update((state) => true);
          },
        );
      },
      onDisposed: () {
        SocketIo.instance.disconnect();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Yoyo Chatt",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                currentUser.name,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ],
          ),
          actions: [
            Consumer(
              builder: (context, ref, child) {
                return PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          context.router.push(const NewGroupRoute());
                        },
                        child: const Text("New Group"),
                      ),
                      PopupMenuItem(
                        onTap: () async {
                          final result =
                              await ref.read(authControllerProvider).signOut();

                          result.fold(
                            (l) => eLog("Error on while logging out."),
                            (r) =>
                                context.router.replaceAll([const LoginRoute()]),
                          );
                        },
                        child: const Text("Logout"),
                      ),
                    ];
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showSearch(context, ref),
          child: const Icon(Icons.message),
        ),
        body: chatsState.map(
          initial: (_) => const SizedBox(),
          loading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          empty: (_) => Center(
            child: Text(
              "No chats available.",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          success: (_) {
            final chats = _.chats;

            return RefreshIndicator(
              onRefresh: () async {
                ref.read(getChatsNotifierProvider.notifier).getAllChats();
              },
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  final chat = chats[index];

                  return ChatListItem(
                    key: ValueKey(chat.id),
                    chat: chat,
                    currentUser: currentUser,
                    onTap: (chat) {
                      ref
                          .read(selectedChatProvider.notifier)
                          .update((state) => chat);
                      context.router.push(const ChatRoute());
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: chats.length,
              ),
            );
          },
          error: (_) => Center(
            child: Text(
              _.failure.message ?? "Unknown error",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }

  void _showSearch(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);

    showSearch(
      context: context,
      delegate: SearchPage<UserEntity>(
        items: users,
        searchLabel: 'Search people',
        suggestion: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                size: 25.0,
                color: Colors.grey,
              ),
              Text(
                'Search users by username',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        failure: const Center(
          child: Text(
            'No person found :(',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        filter: (user) => [
          user.email,
        ],
        builder: (user) => ListTile(
          leading: const Icon(Icons.account_circle, size: 50.0),
          title: Text(user.name),
          subtitle: Text(user.email),
          onTap: () {
            /// selected user
            // ref.read(selectedChatUserProvider.notifier).update((state) => user);

            ref
                .read(createOrAccessChatProvider.notifier)
                .createOrAccessChat(userId: user.id);

            /// push to chat screen
            // context.router.push(const ChatRoute());
          },
        ),
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.chat,
    required this.currentUser,
    required this.onTap,
  });

  final ChatEntity chat;
  final UserEntity currentUser;
  final void Function(ChatEntity) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: chat.isGroupChat ? null : Colors.transparent,
        child: chat.isGroupChat
            ? Text(chat.name.characters.first)
            : ClipOval(
                child: Image.network(
                  ChatHelpers.getSenderFull(currentUser, chat.users).avatar,
                ),
              ),
      ),
      title: Text(
        chat.isGroupChat
            ? chat.name
            : ChatHelpers.getSender(currentUser, chat.users),
      ),
      subtitle: chat.latestMessage != null
          ? Text(
              "${ChatHelpers.isSameUser(currentUser, chat.latestMessage!.sender) ? "You" : chat.latestMessage!.sender.name} ${chat.latestMessage?.content}",
            )
          : null,
      onTap: () => onTap(chat),
    );
  }
}
