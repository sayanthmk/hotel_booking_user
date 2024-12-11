import 'package:hotel_booking/features/home/data/datasourse/hotel_remote_datasourse.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/domain/repos/hotel_domain_repositary.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelRemoteDataSource remoteDataSource;

  HotelRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<HotelEntity>> fetchHotels() async {
    // log('HotelRepositoryImpl: Fetching all hotels');
    try {
      final hotels = await remoteDataSource.fetchHotels();
      // log('HotelRepositoryImpl: Successfully fetched ${hotels.length} hotels');
      return hotels;
    } catch (error) {
      // log('HotelRepositoryImpl: Error fetching hotels - $error');
      rethrow;
    }
  }

  @override
  Future<HotelEntity?> fetchHotelById(String hotelId) async {
    // log('HotelRepositoryImpl: Fetching hotel by ID $hotelId');
    try {
      final hotel = await remoteDataSource.fetchHotelById(hotelId);
      if (hotel != null) {
        // log('HotelRepositoryImpl: Successfully fetched hotel with ID $hotelId');
      } else {
        // log('HotelRepositoryImpl: Hotel with ID $hotelId not found');
      }
      return hotel;
    } catch (error) {
      // log('HotelRepositoryImpl: Error fetching hotel by ID $hotelId - $error');
      rethrow;
    }
  }
}
