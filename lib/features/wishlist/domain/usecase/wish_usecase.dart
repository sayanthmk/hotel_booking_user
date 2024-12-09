import 'package:hotel_booking/features/wishlist/domain/repos/wish_repos.dart';

class AddHotelToFavorites {
  final FavoritesRepository repository;

  AddHotelToFavorites(this.repository);

  Future<void> call(String hotelId) {
    return repository.addHotelToFavorites(hotelId);
  }
}

class GetFavoriteHotels {
  final FavoritesRepository repository;

  GetFavoriteHotels(this.repository);

  Stream<List<String>> call() {
    return repository.getFavoriteHotels();
  }
}

class RemoveHotelFromFavorites {
  final FavoritesRepository repository;

  RemoveHotelFromFavorites(this.repository);

  Future<void> call(String hotelId) {
    return repository.removeHotelFromFavorites(hotelId);
  }
}
