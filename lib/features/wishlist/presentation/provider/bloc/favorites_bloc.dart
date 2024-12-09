// lib/features/home/presentation/bloc/favorites_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/wishlist/domain/usecase/wish_usecase.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AddHotelToFavorites addHotelToFavorites;
  final GetFavoriteHotels getFavoriteHotels;
  final RemoveHotelFromFavorites removeHotelFromFavorites;

  FavoritesBloc({
    required this.addHotelToFavorites,
    required this.getFavoriteHotels,
    required this.removeHotelFromFavorites,
  }) : super(FavoritesInitial()) {
    on<AddToFavoritesEvent>(_onAddToFavorites);
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavorites);
  }

  void _onAddToFavorites(
      AddToFavoritesEvent event, Emitter<FavoritesState> emit) async {
    try {
      emit(FavoritesLoading());
      await addHotelToFavorites(event.hotelId);
      emit(FavoriteAdded());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  void _onLoadFavorites(
      LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    try {
      emit(FavoritesLoading());
      final favorites = getFavoriteHotels();
      await for (var favorite in favorites) {
        emit(FavoritesLoaded(favorite));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  void _onRemoveFromFavorites(
      RemoveFromFavoritesEvent event, Emitter<FavoritesState> emit) async {
    try {
      emit(FavoritesLoading());
      await removeHotelFromFavorites(event.hotelId);
      emit(FavoriteRemoved());
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
