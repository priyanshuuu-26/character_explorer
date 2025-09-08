import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../data/character_model.dart';

// Provider to hold the current search query string
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider to hold the current status filter (Alive or Dead)
final statusFilterProvider = StateProvider<String>((ref) => '');
// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// The State class that holds character list data
class CharacterState {
  final List<Character> characters;
  final int currentPage;
  final bool isLoading;
  final bool hasMore;

  CharacterState({
    this.characters = const [],
    this.currentPage = 1,
    this.isLoading = false,
    this.hasMore = true,
  });

  CharacterState copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? isLoading,
    bool? hasMore,
  }) {
    return CharacterState(
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// The StateNotifier that manages the CharacterState
class CharacterNotifier extends StateNotifier<CharacterState> {
  final ApiService _apiService;

  CharacterNotifier(this._apiService) : super(CharacterState()) {
    // Fetch the first page of characters when the notifier is created
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    // Don't fetch if we are already loading or if there are no more pages
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    final newCharacters = await _apiService.getCharacters(page: state.currentPage);

    // If the API returns an empty list
    if (newCharacters.isEmpty) {
      state = state.copyWith(isLoading: false, hasMore: false);
    } else {
      state = state.copyWith(
        characters: [...state.characters, ...newCharacters],
        currentPage: state.currentPage + 1,
        isLoading: false,
      );
    }
  }
}

// The final StateNotifierProvider that the UI will interact with
final characterNotifierProvider =
    StateNotifierProvider<CharacterNotifier, CharacterState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return CharacterNotifier(apiService);
});

final filteredCharactersProvider = Provider<List<Character>>((ref) {
  // Watch all the providers
  final characterState = ref.watch(characterNotifierProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final statusFilter = ref.watch(statusFilterProvider);

  List<Character> characters = characterState.characters;

  // Status filter
  if (statusFilter.isNotEmpty) {
    characters = characters.where((char) => char.status == statusFilter).toList();
  }

  // Search query
  if (searchQuery.isNotEmpty) {
    characters = characters
        .where((char) => char.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  return characters;
});