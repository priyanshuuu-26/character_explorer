import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get a stream of the user's favorite character IDs
  Stream<List<int>> getFavoritesStream() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]); // Return empty stream if user is not logged in
    }

    return _db
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => int.parse(doc.id)).toList();
    });
  }

  // Add a character to the user's favorites
  Future<void> addFavorite(int characterId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(characterId.toString()) // Use character ID as document ID
        .set({
      'favoritedAt': Timestamp.now(), // Store a timestamp
    });
  }

  // Remove a character from the user's favorites
  Future<void> removeFavorite(int characterId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(characterId.toString())
        .delete();
  }
}