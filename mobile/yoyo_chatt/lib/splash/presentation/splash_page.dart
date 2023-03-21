import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/controller/auth_controller.dart';
import 'package:yoyo_chatt/core/providers/core_providers.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulHookConsumerWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    _initialize();
    super.didChangeDependencies();
  }

  Future<void> _initialize() async {
    if (!_isInit) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final authData = await ref.read(authControllerProvider).getUserData();
      eLog(authData);

      if (!mounted) return;

      if (authData != null) {
        ref.read(currentUserProvider.notifier).update((state) => authData);
        context.router.replaceAll(const [ChatListRoute()]);
      } else {
        ref.read(currentUserProvider.notifier).update((state) => null);
        context.router.replaceAll(const [LoginRoute()]);
      }

      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
