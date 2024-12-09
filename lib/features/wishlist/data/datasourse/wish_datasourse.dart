import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FavoritesRemoteDataSource {
  Future<void> addHotelToFavorites(String hotelId);
  Stream<List<String>> getFavoriteHotels();
  Future<void> removeHotelFromFavorites(String hotelId);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FavoritesRemoteDataSourceImpl({required this.firestore, required this.auth});

  @override
  Future<void> addHotelToFavorites(String hotelId) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user');
      }

      final docref = firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('favourites')
          .doc(hotelId);
      final docsnapshot = await docref.get();
      if (docsnapshot.exists) {
        throw Exception('Hotel is Already added');
      }
      await docref.set({
        'hotelId': hotelId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Add to favorites failed: $e');
    }
  }

  @override
  Stream<List<String>> getFavoriteHotels() async* {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user');
      }

      final querySnapshot = await firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('favourites')
          .get();

      yield querySnapshot.docs.map((doc) => doc['hotelId'] as String).toList();
    } catch (e) {
      throw Exception('Fetch favorites failed: $e');
    }
  }

  @override
  Future<void> removeHotelFromFavorites(String hotelId) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user');
      }

      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('favourites')
          .doc(hotelId)
          .delete();
    } catch (e) {
      throw Exception('Remove from favorites failed: $e');
    }
  }
}
