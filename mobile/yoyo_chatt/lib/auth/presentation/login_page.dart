import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo_chatt/auth/cubit/guest_cubit.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: const [
          LoginForm(),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuestCubit>();

    return Form(
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
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Email",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
            ),
          ),
          const SizedBox(height: 20),
          if (_isLoading) const CircularProgressIndicator(),
          if (!_isLoading)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  final result = await cubit.signIn(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );

                  if (result != null) {
                    setState(() {
                      _errorMessage = result;
                    });
                  } else {
                    if (!mounted) return;

                    context.router.replaceAll([const HomeRoute()]);
                  }

                  setState(() {
                    _isLoading = false;
                  });
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("LOGIN"),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
