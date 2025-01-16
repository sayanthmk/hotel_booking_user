import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseReviewDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth auth;

  FirebaseReviewDataSource(this._firestore, this.auth);

  Future<void> addReview(ReviewModel review, String hotelId) async {
    const uuid = Uuid();
    try {
      final User? currentUser = auth.currentUser;

      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }
      final String reviewId = uuid.v4();
      final String userEmail = currentUser.email!;
      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reviews')
          .doc(reviewId);
      log('Review datasourse called');
      await bookingRef.set(
        {
          'userId': currentUser.uid,
          'hotelId': hotelId,
          'reviewId': reviewId,
          'userEmail': userEmail,
          'reviewDetails': review.toMap(),
        },
      );

      await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('reviews')
          .doc(reviewId)
          .set(
        {
          'hotelId': hotelId,
          'reviewId': reviewId,
          'userEmail': userEmail,
          'reviewDetails': review.toMap(),
        },
      );
    } catch (e) {
      throw Exception('Failed to save user reviews: $e');
    }
  }

  Future<List<ReviewModel>> fetchReviews(String hotelId) async {
    final querySnapshot = await _firestore
        .collection('approved_hotels')
        .doc(hotelId)
        .collection('reviews')
        .orderBy('reviewDetails', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => ReviewModel.fromMap(doc.data(), id: doc.id))
        .toList();
  }

  Future<void> deleteReview(String reviewId, String hotelId) async {
    try {
      final User? currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reviews')
          .doc(reviewId)
          .delete();

      await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('reviews')
          .doc(reviewId)
          .delete();

      log('Review deleted successfully');
    } catch (e) {
      throw Exception('Failed to delete review: $e');
    }
  }
}
