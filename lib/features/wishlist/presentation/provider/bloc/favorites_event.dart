part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddToFavoritesEvent extends FavoritesEvent {
  final String hotelId;

  const AddToFavoritesEvent(this.hotelId);

  @override
  List<Object> get props => [hotelId];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class RemoveFromFavoritesEvent extends FavoritesEvent {
  final String hotelId;
  const RemoveFromFavoritesEvent(this.hotelId);

  @override
  List<Object> get props => [hotelId];
}
