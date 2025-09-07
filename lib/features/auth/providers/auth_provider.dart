import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/auth_service.dart';

// Provides an instance of our AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// A stream provider that listens to auth state changes.
// Riverpod will automatically handle the stream and rebuild widgets when the user logs in or out.
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});