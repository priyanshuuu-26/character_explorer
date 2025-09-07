import 'package:character_explorer/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Explorer'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            // By calling read, we trigger the signInWithGoogle method once on tap
            ref.read(authServiceProvider).signInWithGoogle();
          },
          icon: const Icon(Icons.login), // You can find a Google icon
          label: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}