import 'package:dio/dio.dart';
import '../../features/characters/data/character_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  // Fetches a list of characters
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get('/character', queryParameters: {'page': page});
      final List results = response.data['results'];
      return results.map((e) => Character.fromJson(e)).toList();
    } on DioException catch (e) {
      print('Error fetching characters: $e');
      return [];
    }
  }

  // Fetches multiple characters by a list of IDs
  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    // If the list of IDs is empty return an empty list
    if (ids.isEmpty) {
      return [];
    }

    try {
      final response = await _dio.get('/character/${ids.join(',')}');
      
      final dynamic data = response.data;
      if (data is List) {
        return data.map((e) => Character.fromJson(e)).toList();
      } else if (data is Map<String, dynamic>) {
        return [Character.fromJson(data)];
      }
      return [];
    } on DioException catch (e) {
      print('Error fetching characters by IDs: $e');
      return [];
    }
  }
}