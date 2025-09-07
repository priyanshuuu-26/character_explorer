import 'package:character_explorer/features/characters/data/character_model.dart';
import 'package:character_explorer/features/characters/providers/character_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firestore_service.dart';

// Provider for the FirestoreService instance
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

// A StreamProvider that provides a real-time list of favorite character IDs.
// The UI will automatically rebuild whenever this list changes.
final favoritesStreamProvider = StreamProvider<List<int>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getFavoritesStream();
});

final favoriteCharactersProvider = FutureProvider<List<Character>>((ref) async {
  // Watch the stream of favorite IDs from Firestore.
  final favoriteIds = ref.watch(favoritesStreamProvider).value ?? [];

  // If there are no favorite IDs, return an empty list immediately.
  if (favoriteIds.isEmpty) {
    return [];
  }

  // Get the ApiService instance.
  final apiService = ref.watch(apiServiceProvider);

  // Fetch the full character data for the favorite IDs.
  return apiService.getCharactersByIds(favoriteIds);
});