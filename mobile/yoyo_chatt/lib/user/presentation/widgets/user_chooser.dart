import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/user/shared/user_providers.dart';

final userSuggestionProvider =
    StateProvider.autoDispose<List<UserEntity>>((ref) {
  return [];
});

class UserChooser extends HookConsumerWidget {
  const UserChooser({
    super.key,
    this.scrollController,
    this.onItemTap,
  });

  final ScrollController? scrollController;
  final Function(UserEntity)? onItemTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(getUsersNotifierProvider);
    final suggestions = ref.watch(userSuggestionProvider);

    return Column(
      children: [
        const SizedBox(height: 20),
        const UserSearchField(),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: userState.map(
              initial: (_) => const SizedBox(),
              loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              empty: (_) => Center(
                child: Text(
                  "No users found",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              success: (_) {
                final users = _.users;

                return UserChooserList(
                  users: suggestions.isEmpty ? users : suggestions,
                  onItemTap: onItemTap,
                );
              },
              error: (_) => Center(
                child: Text(
                  _.failure.message ?? "Unknown error occurred",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserChooserList extends StatelessWidget {
  const UserChooserList({
    super.key,
    required this.users,
    this.onItemTap,
  });

  final List<UserEntity> users;
  final Function(UserEntity)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          onTap: () {
            if (onItemTap != null) {
              onItemTap!(user);
            }
          },
          title: Text(user.name),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: users.length,
    );
  }
}

class UserSearchField extends StatefulHookConsumerWidget {
  const UserSearchField({
    super.key,
  });

  @override
  ConsumerState<UserSearchField> createState() => _UserSearchFieldState();
}

class _UserSearchFieldState extends ConsumerState<UserSearchField> {
  final controller = TextEditingController();

  void search(String keyword, List<UserEntity> users) {
    if (keyword.isEmpty) {
      ref.read(userSuggestionProvider.notifier).update((state) => []);
      return;
    }

    final suggestions = users
        .where(
          (element) =>
              element.name.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();

    ref.read(userSuggestionProvider.notifier).update((state) => suggestions);
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userListProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search",
          suffixIcon: IconButton(
            onPressed: () {
              controller.text = '';
              ref.read(userSuggestionProvider.notifier).update((state) => []);
            },
            icon: const Icon(Icons.clear),
          ),
        ),
        onChanged: (value) => search(value, users),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
