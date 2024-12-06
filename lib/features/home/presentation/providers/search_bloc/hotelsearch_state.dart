// hotelsearch_state.dart
import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

abstract class HotelSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelSearchInitialState extends HotelSearchState {}

class HotelSearchLoadingState extends HotelSearchState {}

class HotelSearchLoadedState extends HotelSearchState {
  final List<HotelEntity> filteredHotels;

  HotelSearchLoadedState({required this.filteredHotels});

  @override
  List<Object?> get props => [filteredHotels];
}

class HotelSearchErrorState extends HotelSearchState {
  final String message;

  HotelSearchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
