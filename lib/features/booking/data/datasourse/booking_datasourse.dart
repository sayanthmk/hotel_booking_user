import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:uuid/uuid.dart';

abstract class UserRemoteDataSource {
  Future<void> saveUserBooking(
    UserDataModel userData,
    String hotelId,
  );
  Future<List<UserDataModel>> getUserBookings();

  Future<List<UserDataModel>> getHotelBookings(String hotelId);
  Future<UserDataModel> getSingleUserBooking(String hotelId);
  Future<void> deleteUserBooking(String bookingId, String hotelId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Uuid _uuid = const Uuid();

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
      final String bookingId = _uuid.v4();
      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('bookings')
          .doc(bookingId);

      await bookingRef.set(
        {
          'hotelId': hotelId,
          'bookingId': bookingId,
          'bookingDetails': userData.toMap(),
          'userId': currentUser.uid,
        },
      );

      ////////////////////////////////////////
      await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('bookings')
          .doc(bookingId)
          .set(
        {
          'hotelId': hotelId,
          'bookingId': bookingId,
          'bookingDetails': userData.toMap(),
          'userId': currentUser.uid,
        },
      );
      log('hotel id $hotelId,booking id $bookingId,user id ${currentUser.uid}');
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
      final bookings = querySnapshot.docs
          .map((doc) => UserDataModel.fromMap(doc.data(), id: doc.id))
          .toList();

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
  Future<void> deleteUserBooking(String bookingId, String hotelId) async {
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

      final bookingRefr = _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('bookings')
          .doc(bookingId);

      await bookingRefr.delete();
    } catch (e) {
      throw Exception('Failed to delete user booking: $e');
    }
  }
}
