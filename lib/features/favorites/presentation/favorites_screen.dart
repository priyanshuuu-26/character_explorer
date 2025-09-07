import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorites_provider.dart';
import '../../characters/presentation/widgets/character_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch our new provider to get the list of favorite characters.
    final favoritesAsyncValue = ref.watch(favoriteCharactersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Characters'),
      ),
      body: favoritesAsyncValue.when(
        data: (characters) {
          // If the list is empty, show a message.
          if (characters.isEmpty) {
            return const Center(
              child: Text('You have no favorite characters yet.'),
            );
          }
          // Otherwise, display the list of characters.
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              return CharacterCard(character: characters[index]);
            },
          );
        },
        // Show a loading spinner while fetching data.
        loading: () => const Center(child: CircularProgressIndicator()),
        // Show an error message if something goes wrong.
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}