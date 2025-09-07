import 'package:character_explorer/features/auth/providers/auth_provider.dart';
import 'package:character_explorer/features/favorites/presentation/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/character_providers.dart';
import '../widgets/character_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(characterNotifierProvider.notifier).fetchCharacters();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final characterState = ref.watch(characterNotifierProvider);
    final filteredCharacters = ref.watch(filteredCharactersProvider);

    if (characterState.characters.isEmpty && characterState.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Characters')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authServiceProvider).signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search by name...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    ref.read(searchQueryProvider.notifier).state = query;
                  },
                ),
                const SizedBox(height: 8),
                ToggleButtons(
                  isSelected: [
                    ref.watch(statusFilterProvider) == 'Alive',
                    ref.watch(statusFilterProvider) == 'Dead',
                    ref.watch(statusFilterProvider) == '',
                  ],
                  onPressed: (index) {
                    final notifier = ref.read(statusFilterProvider.notifier);
                    if (index == 0) notifier.state = 'Alive';
                    else if (index == 1) notifier.state = 'Dead';
                    else notifier.state = '';
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  children: const [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Alive')),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Dead')),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('All')),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: characterState.characters.isNotEmpty &&
                    filteredCharacters.isEmpty
                ? const Center(
                    child: Text(
                      'No characters found matching your search.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredCharacters.length +
                        (characterState.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == filteredCharacters.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final character = filteredCharacters[index];
                      return CharacterCard(character: character);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}