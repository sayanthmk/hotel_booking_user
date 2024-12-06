// lib/features/home/domain/repositories/favorites_repository.dart
abstract class FavoritesRepository {
  Future<void> addHotelToFavorites(String hotelId);
  Stream<List<String>> getFavoriteHotels();
  Future<void> removeHotelFromFavorites(String hotelId);
}
