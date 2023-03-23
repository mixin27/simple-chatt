import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/chat/chat_list/shared/chat_providers.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/core/widgets/app_modal_bottom_sheet.dart';
import 'package:yoyo_chatt/core/widgets/modal_dismissible.dart';
import 'package:yoyo_chatt/core/widgets/startup_container.dart';
import 'package:yoyo_chatt/user/presentation/widgets/user_chooser.dart';
import 'package:yoyo_chatt/user/shared/user_providers.dart';

@RoutePage()
class NewGroupPage extends HookConsumerWidget {
  const NewGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(selectedUserIdListProvider.notifier).update((state) => []);
        ref.read(selectedUsersListProvider.notifier).update((state) => []);
        return true;
      },
      child: StartUpContainer(
        onInit: () {
          ref.read(getUsersNotifierProvider.notifier).getAllUsers();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("New Group"),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: const [
              NewGroupChatForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewGroupChatForm extends StatefulHookConsumerWidget {
  const NewGroupChatForm({
    super.key,
  });

  @override
  ConsumerState<NewGroupChatForm> createState() => _NewGroupChatFormState();
}

class _NewGroupChatFormState extends ConsumerState<NewGroupChatForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  void onUserSearchTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ModalDismissible(
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) => AppModalBottomSheet(
            child: UserChooser(
              scrollController: scrollController,
              onItemTap: (user) {
                vLog(user);
                ref
                    .read(selectedUsersListProvider.notifier)
                    .update((state) => [...state, user]);
                ref
                    .read(selectedUserIdListProvider.notifier)
                    .update((state) => [...state, user.id]);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedUsers = ref.watch(selectedUsersListProvider);

    ref.listen(createOrAccessGroupChatProvider, (previous, next) {
      next.maybeMap(
        orElse: () {},
        loading: (_) {
          setState(() {
            _isLoading = true;
          });
        },
        success: (_) {
          setState(() {
            _isLoading = false;
          });
          ref.read(getChatsNotifierProvider.notifier).getAllChats();
          context.router.pop();
        },
        error: (_) {
          setState(() {
            _isLoading = false;
            _errorMessage = _.failure.message ?? "Unknown error occurred.";
          });
        },
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Group Name",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Group name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: onUserSearchTap,
            icon: const Icon(Icons.add),
            label: const Text("Add User"),
          ),
          // TextFormField(
          //   keyboardType: TextInputType.text,
          //   readOnly: true,
          //   decoration: const InputDecoration(
          //     border: OutlineInputBorder(),
          //     hintText: "Add Users To Group",
          //   ),
          //   onTap: onUserSearchTap,
          // ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              selectedUsers.length,
              (index) {
                final user = selectedUsers[index];

                return UserBadgeItem(
                  user: user,
                  onRemove: (user) {},
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          if (!_isLoading)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(createOrAccessGroupChatProvider.notifier)
                        .createOrAccessGroupChat(
                          name: _nameController.text.trim(),
                          userIds: ref.watch(selectedUserIdListProvider),
                        );
                  }
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("CREATE A GROUP"),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

class UserBadgeItem extends StatelessWidget {
  const UserBadgeItem({
    super.key,
    required this.user,
    required this.onRemove,
  });

  final UserEntity user;
  final Function(UserEntity) onRemove;

  @override
  Widget build(BuildContext context) {
    return Badge(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      label: Row(
        children: [
          Text(user.name),
          IconButton(
            onPressed: () => onRemove(user),
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
            ),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      largeSize: 50,
    );
  }
}
