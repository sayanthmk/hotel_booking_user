abstract class FavoritesRepository {
  Future<void> addHotelToFavorites(String hotelId);
  Stream<List<String>> getFavoriteHotels();
  Future<void> removeHotelFromFavorites(String hotelId);
}
