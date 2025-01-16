import 'package:hotel_booking/features/review/data/model/review_model.dart';

abstract class ReviewEvent {}

class AddReview extends ReviewEvent {
  final ReviewModel review;
  final String hotelId;
  AddReview(this.review, this.hotelId);
}

class FetchReviews extends ReviewEvent {
  final String hotelId;
  FetchReviews(this.hotelId);
}

class DeleteReview extends ReviewEvent {
  final String reviewId;
  final String hotelId;
  DeleteReview(this.reviewId, this.hotelId);
}
