import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo_chatt/auth/bloc/auth_bloc.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    _initialize();
    super.didChangeDependencies();
  }

  Future<void> _initialize() async {
    if (!_isInit) {
      await Future.delayed(const Duration(milliseconds: 1500));

      if (!mounted) return;

      final authState = context.read<AuthBloc>().state;
      vLog(authState);

      if (authState.isAuthenticated) {
        context.router.replaceAll(const [HomeRoute()]);
      } else {
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
