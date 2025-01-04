import 'package:hotel_booking/features/review/data/model/review_model.dart';

abstract class ReviewState {}

class UserInitialState extends ReviewState {}

class UserReviewLoadingState extends ReviewState {}

class UserReviewSavedState extends ReviewState {}

class UserReviewLoadedState extends ReviewState {
  final List<ReviewModel> userData;

  UserReviewLoadedState(this.userData);
}

class UserReviewErrorState extends ReviewState {
  final String message;

  UserReviewErrorState(this.message);
}

class UserReviewDeletedState extends ReviewState {}

class SingleUserReviewLoadedState extends ReviewState {
  final ReviewModel booking;
  SingleUserReviewLoadedState(this.booking);
}
