import 'package:hotel_booking/features/wishlist/data/datasourse/wish_datasourse.dart';
import 'package:hotel_booking/features/wishlist/domain/repos/wish_repos.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addHotelToFavorites(String hotelId) {
    return remoteDataSource.addHotelToFavorites(hotelId);
  }

  @override
  Stream<List<String>> getFavoriteHotels() {
    return remoteDataSource.getFavoriteHotels();
  }

  @override
  Future<void> removeHotelFromFavorites(String hotelId) {
    return remoteDataSource.removeHotelFromFavorites(hotelId);
  }
}
