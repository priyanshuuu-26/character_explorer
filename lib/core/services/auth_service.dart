import 'package:character_explorer/features/characters/data/character_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  AuthService() {
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    await _googleSignIn.initialize(
      serverClientId: "225365158647-8apovf01186gs9r56pgr1m6bs2pb602j.apps.googleusercontent.com",
    );
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error during Google sign-in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
Future<List<Character>> getCharactersByIds(List<int> ids, dynamic _dio) async {
  // If the list of IDs is empty, return an empty list to avoid an API error.
  if (ids.isEmpty) {
    return [];
  }

  try {
    // The API accepts a comma-separated string of IDs, e.g., /character/1,2,3
    final response = await _dio.get('/character/${ids.join(',')}');
    
    // The API returns a single object if only one ID is requested,
    // so we need to handle both cases (a single map or a list of maps).
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
