import 'package:hotel_booking/features/review/data/model/review_model.dart';

abstract class ReviewState {}

class UserInitialState extends ReviewState {}

class UserReviewLoadingState extends ReviewState {}

class UserReviewSavedState extends ReviewState {}

class HotelReviewLoadingState extends ReviewState {}

class HotelReviewLoadedState extends ReviewState {
  final List<ReviewModel> userData;

  HotelReviewLoadedState(this.userData);
}

class HotelReviewErrorState extends ReviewState {
  final String message;
  HotelReviewErrorState(this.message);
}

class UserReviewErrorState extends ReviewState {
  final String message;

  UserReviewErrorState(this.message);
}

class UserReviewLoadedState extends ReviewState {}

class UserReviewDeletedState extends ReviewState {}

class SingleUserReviewLoadedState extends ReviewState {
  final ReviewModel booking;
  SingleUserReviewLoadedState(this.booking);
}
