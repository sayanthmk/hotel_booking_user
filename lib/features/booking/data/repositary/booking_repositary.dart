import 'package:hotel_booking/features/booking/data/datasourse/booking_datasourse.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/domain/repos/booking_repos.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveUserBooking(UserDataModel userData, String hotelId) async {
    return await remoteDataSource.saveUserBooking(userData, hotelId);
  }

  @override
  Future<List<UserDataModel>> getUserBookings() async {
    return await remoteDataSource.getUserBookings();
  }

  // @override
  // Future<void> saveHotelBooking({
  //   required String hotelId,
  //   required UserDataModel bookingData,
  // }) async {
  //   return await remoteDataSource.saveHotelBooking(
  //     hotelId: hotelId,
  //     bookingData: bookingData,
  //   );
  // }

  @override
  Future<List<UserDataModel>> getHotelBookings(String hotelId) async {
    return await remoteDataSource.getHotelBookings(hotelId);
  }

  @override
  Future<void> deleteUserBooking(String bookingId, String hotelId) async {
    return await remoteDataSource.deleteUserBooking(bookingId, hotelId);
  }

  // @override
  // Future<void> deleteHotelBooking({
  //   required String hotelId,
  //   required String bookingId,
  // }) async {
  //   return await remoteDataSource.deleteHotelBooking(
  //     hotelId: hotelId,
  //     bookingId: bookingId,
  //   );
  // }

  @override
  Future<UserDataModel> getSingleUserBooking(String bookingId) async {
    return await remoteDataSource.getSingleUserBooking(bookingId);
  }
}
