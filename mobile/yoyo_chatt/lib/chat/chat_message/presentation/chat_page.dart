import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yoyo_chatt/core/widgets/startup_container.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final chatBloc = context.read<ChatBloc>();
    // final authBloc = context.read<AuthBloc>();

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
          title: const Text("Chat"),
        ),
      ),
    );
  }
}
