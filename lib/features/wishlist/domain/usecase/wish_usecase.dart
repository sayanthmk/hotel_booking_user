// lib/features/home/domain/usecases/add_hotel_to_favorites.dart
import 'package:hotel_booking/features/wishlist/domain/repos/wish_repos.dart';

class AddHotelToFavorites {
  final FavoritesRepository repository;

  AddHotelToFavorites(this.repository);

  Future<void> call(String hotelId) {
    return repository.addHotelToFavorites(hotelId);
  }
}

// lib/features/home/domain/usecases/get_favorite_hotels.dart
class GetFavoriteHotels {
  final FavoritesRepository repository;

  GetFavoriteHotels(this.repository);

  Stream<List<String>> call() {
    return repository.getFavoriteHotels();
  }
}

// lib/features/home/domain/usecases/remove_hotel_from_favorites.dart
class RemoveHotelFromFavorites {
  final FavoritesRepository repository;

  RemoveHotelFromFavorites(this.repository);

  Future<void> call(String hotelId) {
    return repository.removeHotelFromFavorites(hotelId);
  }
}
