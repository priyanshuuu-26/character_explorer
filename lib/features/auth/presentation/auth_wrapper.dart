import 'package:character_explorer/features/auth/presentation/login_screen.dart';
import 'package:character_explorer/features/auth/providers/auth_provider.dart';
import 'package:character_explorer/features/characters/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the authStateProvider to know when the user logs in or out
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        // If we have a user object, they are logged in. Show the HomeScreen.
        if (user != null) {
          return const HomeScreen();
        }
        // If user is null, they are logged out. Show the LoginScreen.
        return const LoginScreen();
      },
      // Show a loading screen while we check the auth state
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      // Show an error screen if something goes wrong
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Something went wrong: $error'),
        ),
      ),
    );
  }
}