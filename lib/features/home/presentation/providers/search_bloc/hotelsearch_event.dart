// hotelsearch_event.dart
import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

abstract class HotelSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitializeHotelSearchEvent extends HotelSearchEvent {}

class SearchHotelsEvent extends HotelSearchEvent {
  final List<HotelEntity> allHotels;
  final String query;

  SearchHotelsEvent({required this.allHotels, required this.query});

  @override
  List<Object> get props => [allHotels, query];
}

class FilterHotelsEvent extends HotelSearchEvent {
  final List<String> filters;

  FilterHotelsEvent({required this.filters});

  @override
  List<Object> get props => [filters];
}
