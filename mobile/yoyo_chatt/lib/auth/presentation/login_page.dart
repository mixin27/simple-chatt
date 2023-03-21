import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/auth/controller/auth_controller.dart';
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
        children: [
          const LoginForm(),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              context.router.push(const RegisterRoute());
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulHookConsumerWidget {
  const LoginForm({
    super.key,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
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
            obscureText: true,
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

                  final result = await ref.read(authControllerProvider).signIn(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                  result.fold(
                    (l) {
                      setState(() {
                        _isLoading = false;
                        _errorMessage = l.maybeMap(
                          orElse: () => "Unknown error",
                          server: (_) => _.message,
                        );
                      });
                    },
                    (r) {
                      setState(() {
                        _isLoading = false;
                      });
                      context.router.replaceAll([const ChatListRoute()]);
                    },
                  );
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
