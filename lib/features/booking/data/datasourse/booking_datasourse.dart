import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';

abstract class UserRemoteDataSource {
  Future<void> saveUserBooking(
    UserDataModel userData,
    String hotelId,
  );
  Future<List<UserDataModel>> getUserBookings();

  Future<void> saveHotelBooking({
    required String hotelId,
    required UserDataModel bookingData,
  });

  Future<List<UserDataModel>> getHotelBookings(String hotelId);
  Future<UserDataModel> getSingleUserBooking(String hotelId);
  // New method for deleting a booking
  Future<void> deleteUserBooking(String bookingId);
  Future<void> deleteHotelBooking({
    required String hotelId,
    required String bookingId,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRemoteDataSourceImpl(this._firestore, this._auth);

  @override
  Future<void> saveUserBooking(
    UserDataModel userData,
    String hotelId,
  ) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }
      final String bookingId = _firestore.collection('bookings').doc().id;
      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('bookings')
          .doc();
      // log('users/bookings');
      // await bookingRef.set(userData.toMap());
      await bookingRef.set({
        'hotelId': hotelId,
        'bookingId': bookingRef.id,
        'bookingDetails': userData.toMap(),
      });
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
  Future<UserDataModel> getSingleUserBooking(String bookingId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final docSnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('bookings')
          .doc(bookingId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception('Booking with ID $bookingId not found');
      }

      log('Fetching single user booking...');
      log('Document ID: ${docSnapshot.id}');
      log('Document Data: ${docSnapshot.data()}');

      return UserDataModel.fromMap(docSnapshot.data()!, id: docSnapshot.id);
    } catch (e) {
      throw Exception('Failed to retrieve booking details: $e');
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
      final bookingMap = bookingData.toMap();
      // bookingMap['userId'] = currentUser.uid;

      final bookingRef = _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('bookings')
          .doc();
      // log('users/bookings/save');
      await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('bookings')
          .doc(bookingRef.id)
          .set({
        'hotelId': hotelId,
        'bookingId': bookingRef.id,
        'bookingDetails': bookingMap,
      });

      // await bookingRef.set(bookingMap);

      // await _firestore
      //     .collection('users')
      //     .doc(currentUser.uid)
      //     .collection('bookings')
      //     .doc(bookingRef.id)
      //     .set({
      //   'hotelId': hotelId,
      //   'bookingDetails': bookingMap,
      // });
    } catch (e) {
      throw Exception('Failed to save hotel booking: $e');
    }
  }

  @override
  Future<List<UserDataModel>> getHotelBookings(String hotelId) async {
    try {
      final querySnapshot = await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('bookings')
          .get();
      // log('users/bookings/get hotel');
      return querySnapshot.docs
          .map((doc) => UserDataModel.fromMap(doc.data(), id: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to retrieve hotel bookings: $e');
    }
  }

  @override
  Future<void> deleteUserBooking(String bookingId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('bookings')
          .doc(bookingId);

      await bookingRef.delete();
      // log('Deleted user booking with ID: $bookingId');
    } catch (e) {
      throw Exception('Failed to delete user booking: $e');
    }
  }

  @override
  Future<void> deleteHotelBooking({
    required String hotelId,
    required String bookingId,
  }) async {
    try {
      final bookingRef = _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('bookings')
          .doc(bookingId);

      await bookingRef.delete();
      log('Deleted hotel booking with ID: $bookingId in hotel: $hotelId');
    } catch (e) {
      throw Exception('Failed to delete hotel booking: $e');
    }
  }
}
