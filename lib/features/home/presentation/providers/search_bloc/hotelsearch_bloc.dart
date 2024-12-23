import 'package:bloc/bloc.dart';

import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_state.dart';

class HotelSearchBloc extends Bloc<HotelSearchEvent, HotelSearchState> {
  HotelSearchBloc() : super(HotelSearchInitialState()) {
    on<InitializeHotelSearchEvent>(_onInitializeSearch);
    on<SearchHotelsEvent>(_onSearchHotels);
    on<FilterHotelsEvent>(_onFilterHotels);
  }

  void _onInitializeSearch(
      InitializeHotelSearchEvent event, Emitter<HotelSearchState> emit) {
    emit(HotelSearchInitialState());
  }

  void _onSearchHotels(
      SearchHotelsEvent event, Emitter<HotelSearchState> emit) {
    emit(HotelSearchLoadingState());

    try {
      final filteredHotels = event.allHotels.where((hotel) {
        final query = event.query.toLowerCase();
        return hotel.hotelName.toLowerCase().contains(query) ||
            hotel.city.toLowerCase().contains(query);
      }).toList();

      emit(HotelSearchLoadedState(filteredHotels: filteredHotels));
    } catch (e) {
      emit(HotelSearchErrorState(
          message: 'Error searching hotels: ${e.toString()}'));
    }
  }

  void _onFilterHotels(
      FilterHotelsEvent event, Emitter<HotelSearchState> emit) {
    if (state is! HotelSearchLoadedState) return;

    final currentHotels = (state as HotelSearchLoadedState).filteredHotels;

    try {
      final filteredHotels = currentHotels.where((hotel) {
        final matchesFacilities = event.filters.every((filter) {
          switch (filter) {
            case 'Parking':
              return hotel.coupleFriendly;
            case 'Couple Friendly':
              return hotel.parkingFacility;
            default:
              return true;
          }
        });

        return matchesFacilities;
      }).toList();

      emit(HotelSearchLoadedState(filteredHotels: filteredHotels));
    } catch (e) {
      emit(HotelSearchErrorState(
          message: 'Error filtering hotels: ${e.toString()}'));
    }
  }
}
