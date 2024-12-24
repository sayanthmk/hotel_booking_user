import 'package:hotel_booking/features/booking/data/model/booking_model.dart';

abstract class UserRepository {
  Future<void> saveUserBooking(UserDataModel userData, String hotelId);
  Future<List<UserDataModel>> getUserBookings();

  Future<List<UserDataModel>> getHotelBookings(String hotelId);
  Future<void> deleteUserBooking(String bookingId, String hotelId);

  Future<UserDataModel> getSingleUserBooking(String bookingId);
}
