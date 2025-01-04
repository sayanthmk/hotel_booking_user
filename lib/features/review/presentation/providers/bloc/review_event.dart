import 'package:hotel_booking/features/review/data/model/review_model.dart';

abstract class ReviewEvent {}

class SaveUserReviewEvent extends ReviewEvent {
  final ReviewModel userData;
  final String hotelId;

  SaveUserReviewEvent(this.userData, this.hotelId);
}

class GetUserReviewEvent extends ReviewEvent {}

class GetHotelReviewEvent extends ReviewEvent {
  final String hotelId;

  GetHotelReviewEvent(this.hotelId);
}

class DeleteUserReviewEvent extends ReviewEvent {
  final String bookingId;
  final String hotelId;

  DeleteUserReviewEvent(this.bookingId, this.hotelId);
}

class GetSingleUserReviewEvent extends ReviewEvent {
  final String bookingId;
  GetSingleUserReviewEvent(this.bookingId);
}
