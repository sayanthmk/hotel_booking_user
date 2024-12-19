import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking/features/home/data/model/hotel_model.dart';

abstract class HotelRemoteDataSource {
  Future<List<HotelModel>> fetchHotels();
  Future<HotelModel?> fetchHotelById(String hotelId);
}

class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final FirebaseFirestore firestore;

  HotelRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<HotelModel>> fetchHotels() async {
    //  log('HotelRemoteDataSource: Fetching hotel by ID $hotelId');
    // log('HotelRemoteDataSource: Fetching all hotels');
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('approved_hotels')
          .where('status', isEqualTo: 'approved')
          .get();
      return querySnapshot.docs
          .map((doc) => HotelModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // log('Error fetching hotels: $e');
      rethrow;
    }
  }

  @override
  Future<HotelModel?> fetchHotelById(String hotelId) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('approved_hotels').doc(hotelId).get();
      if (doc.exists) {
        return HotelModel.fromJson(doc.data() as Map<String, dynamic>);
          //     return querySnapshot.docs
          // .map((docst) => HotelModel.fromJson(docst.data() as Map<String, dynamic>))
          // .toList();
      } else {
        // log('Hotel with ID $hotelId does not exist');
        return null;
      }
    } catch (e) {
      // log('Error fetching hotel by ID $hotelId: $e');
      rethrow;
    }
  }

}
  // @override
  // Future<HotelModel?> fetchHotelById(String hotelId) async {
  //   try {
  //     DocumentSnapshot doc =
  //         await firestore.collection('approved_hotels').doc(hotelId).get();
  //     if (doc.exists) {
  //       final data = doc.data();
  //       if (data != null) {
  //         return HotelModel.fromJson(data as Map<String, dynamic>);
  //       }
  //     }
  //     print('Hotel with ID $hotelId does not exist or has no data.');
  //     return null;
  //   } catch (e) {
  //     print('Error fetching hotel by ID $hotelId: $e');
  //     rethrow;
  //   }
  // }