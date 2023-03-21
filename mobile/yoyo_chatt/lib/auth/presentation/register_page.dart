import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';

import '../../core/providers/core_providers.dart';
import '../controller/auth_controller.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: const [
          RegisterForm(),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulHookConsumerWidget {
  const RegisterForm({
    super.key,
  });

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _nameController = TextEditingController();
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
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Name",
            ),
          ),
          const SizedBox(height: 10),
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
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          if (!_isLoading)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  final result = await ref.read(authControllerProvider).signUp(
                        name: _nameController.text.trim(),
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
                      ref
                          .read(currentUserProvider.notifier)
                          .update((state) => r);
                      context.router.replaceAll([const ChatListRoute()]);
                    },
                  );
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("SIGN UP"),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
