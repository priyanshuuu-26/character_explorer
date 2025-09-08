import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/auth_service.dart';

// Provides an instance of AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Stream provider that listens to auth state changes
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});