import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_page/search_page.dart';
import 'package:yoyo_chatt/auth/controller/auth_controller.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/chat/chat_list/models/chat_model.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/core/widgets/startup_container.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';

@RoutePage()
class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StartUpContainer(
      onInit: () {},
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
                "currentUser.name",
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
        // floatingActionButton:
        //     BlocSelector<UserBloc, UserState, List<UserEntity>>(
        //   selector: (state) {
        //     return state.map(
        //       initial: (_) => [],
        //       loaded: (state) => state.users,
        //     );
        //   },
        //   builder: (context, state) {
        //     return FloatingActionButton(
        //       onPressed: () => _showSearch(context, state),
        //       child: const Icon(Icons.message),
        //     );
        //   },
        // ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return const SizedBox();

              // return ChatListItem(
              //   key: ValueKey(chat.id),
              //   chat: chat,
              //   currentUser: currentUser,
              //   onTap: (chat) {
              //     chatBloc.add(ChatSelected(chat));
              //     vLog(chat);
              //     context.router.push(const ChatRoute());
              //   },
              // );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: 10,
          ),
        ),
      ),
    );
  }

  void _showSearch(BuildContext context, List<UserEntity> users) {
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
            // context.read<ChatBloc>().add(UserSelected(user));

            /// push to chat screen
            context.router.push(const ChatRoute());
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
      leading: const Icon(Icons.account_circle, size: 50.0),
      title: Text(chat.name),
      onTap: () => onTap(chat),
    );
  }
}
