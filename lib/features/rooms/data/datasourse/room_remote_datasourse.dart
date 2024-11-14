import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking/features/rooms/data/model/rooms_model.dart';

abstract class RoomRemoteDataSource {
  Future<List<RoomModel>> getRoomsForHotel(String hotelId);
}

class FirebaseRoomRemoteDataSource implements RoomRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirebaseRoomRemoteDataSource(this._firestore);

  @override
  Future<List<RoomModel>> getRoomsForHotel(String hotelId) async {
    try {
      final roomsSnapshot = await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('rooms')
          .get();

      return roomsSnapshot.docs
          .map((doc) => RoomModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch rooms: $e');
    }
  }
}
