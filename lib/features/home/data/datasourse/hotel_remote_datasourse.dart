import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking/features/home/data/model/hotel_model.dart';

abstract class HotelRemoteDataSource {
  Future<List<HotelModel>> fetchHotels();
  Future<HotelModel?> fetchHotelById(String hotelId); // New method
}

class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final FirebaseFirestore firestore;

  HotelRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<HotelModel>> fetchHotels() async {
    log('HotelRemoteDataSource: Fetching all hotels');
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('approved_hotels')
          .where('status', isEqualTo: 'approved')
          .get();
      return querySnapshot.docs
          .map((doc) => HotelModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching hotels: $e');
      rethrow;
    }
  }

  @override
  Future<HotelModel?> fetchHotelById(String hotelId) async {
    log('HotelRemoteDataSource: Fetching hotel by ID $hotelId');
    try {
      DocumentSnapshot doc =
          await firestore.collection('approved_hotels').doc(hotelId).get();
      if (doc.exists) {
        return HotelModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        log('Hotel with ID $hotelId does not exist');
        return null;
      }
    } catch (e) {
      log('Error fetching hotel by ID $hotelId: $e');
      rethrow;
    }
  }
}
