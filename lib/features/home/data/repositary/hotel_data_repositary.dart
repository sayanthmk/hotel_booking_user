import 'package:hotel_booking/features/home/data/datasourse/hotel_remote_datasourse.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/domain/repos/hotel_domain_repositary.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelRemoteDataSource remoteDataSource;

  HotelRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<HotelEntity>> fetchHotels() async {
    try {
      final hotels = await remoteDataSource.fetchHotels();
      return hotels;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<HotelEntity?> fetchHotelById(String hotelId) async {
    try {
      final hotel = await remoteDataSource.fetchHotelById(hotelId);
      if (hotel != null) {
      } else {}
      return hotel;
    } catch (error) {
      rethrow;
    }
  }
}
