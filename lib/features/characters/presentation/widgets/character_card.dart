import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. Import Riverpod
import '../../data/character_model.dart';
import '../screens/character_detail_screen.dart';
import '../../../../core/providers/core_providers.dart'; // 2. Import the new provider

// 3. Make the widget a ConsumerWidget
class CharacterCard extends ConsumerWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // 4. Add WidgetRef
    // 5. Watch the remote config provider
    final remoteConfigAsync = ref.watch(remoteConfigProvider);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(character: character),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Hero(
            tag: 'character_${character.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl: character.imageUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(character.name),
          subtitle: Text('${character.status} - ${character.species}'),
          // 6. Use the remote config value to build the trailing widget
          trailing: remoteConfigAsync.when(
            data: (configService) {
              // If the flag is true, show the episode count
              if (configService.showEpisodeCount) {
                return Text('Episodes: ${character.episodeCount}');
              }
              // Otherwise, show an empty widget
              return const SizedBox.shrink();
            },
            // Show nothing while loading or if there's an error
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}