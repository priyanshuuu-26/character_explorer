import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. Import Riverpod
import '../../data/character_model.dart';
import '../../../favorites/providers/favorites_provider.dart'; // 2. Import the new providers

// 3. Make the widget a ConsumerWidget
class CharacterDetailScreen extends ConsumerWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // 4. Add WidgetRef
    // 5. Watch the stream of favorite IDs
    final favoritesAsyncValue = ref.watch(favoritesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        // ... (The top part of your Column remains the same)
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'character_${character.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: character.imageUrl,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 250,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoRow(context, 'Status:', character.status),
            _buildInfoRow(context, 'Species:', character.species),
            _buildInfoRow(context, 'Episodes Appeared In:', '${character.episodeCount}'),
            const SizedBox(height: 24),
            
            // 6. Use the favorites data to build the button
            favoritesAsyncValue.when(
              data: (favoriteIds) {
                final isFavorite = favoriteIds.contains(character.id);
                return ElevatedButton.icon(
                  onPressed: () {
                    final firestoreService = ref.read(firestoreServiceProvider);
                    if (isFavorite) {
                      firestoreService.removeFavorite(character.id);
                    } else {
                      firestoreService.addFavorite(character.id);
                    }
                  },
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  label: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFavorite ? Colors.red : null,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const Text('Could not load favorites'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget remains the same
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    // ...
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}