import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo_chatt/auth/bloc/auth_bloc.dart';
import 'package:yoyo_chatt/auth/cubit/guest_cubit.dart';
import 'package:yoyo_chatt/auth/repositories/auth_repository.dart';
import 'package:yoyo_chatt/routes/app_router.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
          BlocProvider(
            create: (context) => GuestCubit(
              authRepository: context.read<AuthRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'Yoyo Chatt',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          ),
          routerConfig: _appRouter.config(),
        ),
      ),
    );
  }
}
