import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class NewGroupPage extends StatelessWidget {
  const NewGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: const [
          NewGroupChatForm(),
        ],
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
  final _nameController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Group Name",
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search users",
            ),
            onChanged: (value) {},
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              UserBadgeItem(
                user: "Mixin",
                onRemove: (user) {},
              ),
              UserBadgeItem(
                user: "Kate",
                onRemove: (user) {},
              ),
              UserBadgeItem(
                user: "Bob",
                onRemove: (user) {},
              ),
              UserBadgeItem(
                user: "James",
                onRemove: (user) {},
              ),
              UserBadgeItem(
                user: "MS",
                onRemove: (user) {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          if (!_isLoading)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {},
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

  final String user;
  final Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return Badge(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      label: Row(
        children: [
          Text(user),
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
