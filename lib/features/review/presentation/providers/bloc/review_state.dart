import 'package:hotel_booking/features/review/data/model/review_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<ReviewModel> reviews;
  ReviewLoaded(this.reviews);
}
