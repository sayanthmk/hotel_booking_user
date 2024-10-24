import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking/features/home/data/model/hotel_model.dart';

abstract class HotelRemoteDataSource {
  Future<List<HotelModel>> fetchHotels();
}

class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final FirebaseFirestore firestore;

  HotelRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<HotelModel>> fetchHotels() async {
    log('data/datasourse called');

    try {
      QuerySnapshot querySnapshot = await firestore.collection('hotels').get();

      // Log each hotel document's ID and data
      for (var doc in querySnapshot.docs) {
        final hotelData = doc.data() as Map<String, dynamic>;

        // Print hotel ID
        log('Fetched Hotel ID: ${doc.id}');

        // Print each detail of the hotel
        // log('Hotel Details:');
        hotelData.forEach((key, value) {
          log('$key: $value');
        });

        // Alternatively, if hotel details are nested
        // if (hotelData.containsKey('hotel details')) {
        //   final details = hotelData['hotel details'] as Map<String, dynamic>;
        //   log('Hotel Details:');
        //   details.forEach((key, value) {
        //     log('$key: $value');
        //   });
        // }
      }

      return querySnapshot.docs
          .map((doc) => HotelModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching hotels: $e');
      print('$e');
      rethrow; // Re-throw the exception for further handling if needed
    }
  }
}
