import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo_chatt/auth/bloc/auth_bloc.dart';
import 'package:yoyo_chatt/auth/cubit/guest_cubit.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<GuestCubit>().signOut();
                },
                icon: const Icon(Icons.logout),
              );
            },
            listener: (context, state) {
              if (!state.isAuthenticated) {
                context.router.replaceAll([const LoginRoute()]);
              }
            },
          ),
        ],
      ),
    );
  }
}
