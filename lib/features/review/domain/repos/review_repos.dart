import 'package:hotel_booking/features/review/data/model/review_model.dart';

abstract class ReviewRepository {
  Future<void> addReview(ReviewModel review, String hotelId);
  Future<List<ReviewModel>> fetchReviews(String hotelId);
  Future<void> deleteReview(String reviewId, String hotelId);
}
