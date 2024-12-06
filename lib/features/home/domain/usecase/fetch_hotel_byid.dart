import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/domain/repos/hotel_domain_repositary.dart';

class FetchHotelsByIdUseCase {
  final HotelRepository repository;

  FetchHotelsByIdUseCase(this.repository);

  Future<HotelEntity?> call(String hotelId) async {
    return await repository.fetchHotelById(hotelId);
  }
}
