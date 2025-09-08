import 'package:character_explorer/features/characters/data/character_model.dart';
import 'package:character_explorer/features/characters/providers/character_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firestore_service.dart';

// Provider for FirestoreService
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

// StreamProvider that provides list of favorite character IDs
final favoritesStreamProvider = StreamProvider<List<int>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getFavoritesStream();
});

final favoriteCharactersProvider = FutureProvider<List<Character>>((ref) async {
  // Watch the stream of favorite IDs from Firestore
  final favoriteIds = ref.watch(favoritesStreamProvider).value ?? [];

  // If there are no favorite IDs, return an empty
  if (favoriteIds.isEmpty) {
    return [];
  }

  // Get the ApiService instance
  final apiService = ref.watch(apiServiceProvider);

  // Fetch character data for the favorite IDs
  return apiService.getCharactersByIds(favoriteIds);
});