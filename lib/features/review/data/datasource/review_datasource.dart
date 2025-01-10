import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:uuid/uuid.dart';

abstract class ReviewDataSource {
  Future<void> saveUserReview(
    ReviewModel reviewData,
    String hotelId,
  );
  Future<List<ReviewModel>> getUserReview();
  Future<List<ReviewModel>> getHotelReview(String hotelId);
  Future<ReviewModel> getSingleUserReview(String hotelId);
  Future<void> deleteUserReview(String bookingId, String hotelId);
}

class ReviewDataSourceImpl implements ReviewDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Uuid _uuid = const Uuid();

  ReviewDataSourceImpl(this._firestore, this._auth);

  @override
  Future<void> saveUserReview(
    ReviewModel reviewData,
    String hotelId,
  ) async {
    try {
      final User? currentUser = _auth.currentUser;
      // final adminId = _firestore.collection('admin').doc().id;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }
      final String reviewId = _uuid.v4();
      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reviews')
          .doc(reviewId);

      await bookingRef.set(
        {
          'userId': currentUser.uid,
          'hotelId': hotelId,
          'reviewId': reviewId,
          'reviewDetails': reviewData.toMap(),
        },
      );

      ////////////////////////////////////////
      await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('reviews')
          .doc(reviewId)
          .set(
        {
          'hotelId': hotelId,
          'reviewId': reviewId,
          'reviewDetails': reviewData.toMap(),
        },
      );
    } catch (e) {
      throw Exception('Failed to save user reviews: $e');
    }
  }

  @override
  Future<List<ReviewModel>> getUserReview() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reviews')
          .get();
      final reports = querySnapshot.docs
          .map((doc) => ReviewModel.fromMap(doc.data(), id: doc.id))
          .toList();

      return reports;
    } catch (e) {
      throw Exception('Failed to retrieve user reviews: $e');
    }
  }

  @override
  Future<ReviewModel> getSingleUserReview(String reviewId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final docSnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reviews')
          .doc(reviewId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception('Booking with ID $reviewId not found');
      }

      //   log('Fetching single user booking...');
      //   log('Document ID: ${docSnapshot.id}');
      //   log('Document Data: ${docSnapshot.data()}');

      return ReviewModel.fromMap(docSnapshot.data()!, id: docSnapshot.id);
    } catch (e) {
      throw Exception('Failed to retrieve report details: $e');
    }
  }

  @override
  Future<List<ReviewModel>> getHotelReview(String hotelId) async {
    try {
      final querySnapshot = await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('reviews')
          .get();
      final reviews = querySnapshot.docs
          .map((doc) => ReviewModel.fromMap(doc.data(), id: doc.id))
          .toList();
      for (var review in reviews) {
        log('Review ID: ${review.id}, Data: ${review.toString()}');
      }
      return reviews;
    } catch (e) {
      throw Exception('Failed to retrieve hotel reviews: $e');
    }
  }

  @override
  Future<void> deleteUserReview(String reviewId, String hotelId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reviews')
          .doc(reviewId);

      await bookingRef.delete();

      final bookingRefr = _firestore
          .collection('admin')
          .doc(hotelId)
          .collection('reviews')
          .doc(reviewId);

      await bookingRefr.delete();
    } catch (e) {
      throw Exception('Failed to delete user booking: $e');
    }
  }
}
