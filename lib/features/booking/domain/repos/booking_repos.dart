import 'package:hotel_booking/features/booking/data/model/booking_model.dart';

abstract class UserRepository {
  Future<void> saveUserBooking(UserDataModel userData);
  Future<List<UserDataModel>> getUserBookings();

  Future<void> saveHotelBooking({
    required String hotelId,
    required UserDataModel bookingData,
  });

  Future<List<UserDataModel>> getHotelBookings(String hotelId);
}
