import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';

abstract class UserRemoteDataSource {
  Future<void> saveUserBooking(UserDataModel userData);
  Future<List<UserDataModel>> getUserBookings();

  Future<void> saveHotelBooking({
    required String hotelId,
    required UserDataModel bookingData,
  });

  Future<List<UserDataModel>> getHotelBookings(String hotelId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRemoteDataSourceImpl(this._firestore, this._auth);

  @override
  Future<void> saveUserBooking(UserDataModel userData) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('bookings')
          .doc();
      log('users/bookings');
      await bookingRef.set(userData.toMap());
    } catch (e) {
      throw Exception('Failed to save user booking: $e');
    }
  }

  @override
  Future<List<UserDataModel>> getUserBookings() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('bookings')
          .get();
      log('users/bookings/get');
      final bookings = querySnapshot.docs
          .map((doc) => UserDataModel.fromMap(doc.data(), id: doc.id))
          .toList();
      log('Fetching user bookings...');
      for (var doc in querySnapshot.docs) {
        log('Document ID: ${doc.id}');
        log('Document Data: ${doc.data()}');
      }

      return bookings;
    } catch (e) {
      throw Exception('Failed to retrieve user bookings: $e');
    }
  }

  @override
  Future<void> saveHotelBooking({
    required String hotelId,
    required UserDataModel bookingData,
  }) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final bookingRef = _firestore
          .collection('hotels')
          .doc(hotelId)
          .collection('bookings')
          .doc();
      log('users/bookings/save');
      final bookingMap = bookingData.toMap();
      bookingMap['userId'] = currentUser.uid;

      await bookingRef.set(bookingMap);

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('bookings')
          .doc(bookingRef.id)
          .set({
        'hotelId': hotelId,
        'bookingDetails': bookingMap,
      });
    } catch (e) {
      throw Exception('Failed to save hotel booking: $e');
    }
  }

  @override
  Future<List<UserDataModel>> getHotelBookings(String hotelId) async {
    try {
      final querySnapshot = await _firestore
          .collection('hotels')
          .doc(hotelId)
          .collection('bookings')
          .get();
      log('users/bookings/get hotel');
      return querySnapshot.docs
          .map((doc) => UserDataModel.fromMap(doc.data(), id: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to retrieve hotel bookings: $e');
    }
  }
}
