import 'package:hotel_booking/features/review/data/model/review_model.dart';

abstract class ReviewRepository {
  Future<void> saveUserReview(ReviewModel userData, String hotelId);
  Future<List<ReviewModel>> getUserReview();

  Future<List<ReviewModel>> getHotelReview(String hotelId);
  Future<void> deleteUserReview(String bookingId, String hotelId);

  Future<ReviewModel> getSingleUserReview(String bookingId);
}
