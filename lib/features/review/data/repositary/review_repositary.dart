import 'package:hotel_booking/features/review/data/datasource/review_datasource.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/domain/repos/review_repos.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveUserReview(ReviewModel userData, String hotelId) async {
    return await remoteDataSource.saveUserReview(userData, hotelId);
  }

  @override
  Future<List<ReviewModel>> getUserReview() async {
    return await remoteDataSource.getUserReview();
  }

  @override
  Future<List<ReviewModel>> getHotelReview(String hotelId) async {
    return await remoteDataSource.getHotelReview(hotelId);
  }

  @override
  Future<void> deleteUserReview(String bookingId, String hotelId) async {
    return await remoteDataSource.deleteUserReview(bookingId, hotelId);
  }

  @override
  Future<ReviewModel> getSingleUserReview(String bookingId) async {
    return await remoteDataSource.getSingleUserReview(bookingId);
  }
}
