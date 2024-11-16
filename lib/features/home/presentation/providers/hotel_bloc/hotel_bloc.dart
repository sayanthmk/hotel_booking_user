import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/domain/repos/hotel_domain_repositary.dart';
import 'hotel_event.dart';
import 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelRepository hotelRepository;

  HotelBloc({required this.hotelRepository}) : super(HotelInitial()) {
    on<LoadHotelsEvent>(_onLoadHotels);
    on<LoadHotelByIdEvent>(_onLoadHotelById);
  }

  Future<void> _onLoadHotels(
      LoadHotelsEvent event, Emitter<HotelState> emit) async {
    emit(HotelLoadingState());
    try {
      final hotels = await hotelRepository.fetchHotels();
      emit(HotelLoadedState(hotels));
    } catch (e) {
      emit(const HotelErrorState('Failed to load hotels.'));
    }
  }

  Future<void> _onLoadHotelById(
      LoadHotelByIdEvent event, Emitter<HotelState> emit) async {
    emit(HotelLoadingState());
    try {
      final hotel = await hotelRepository.fetchHotelById(event.hotelId);
      if (hotel != null) {
        emit(HotelDetailLoadedState(hotel));
      } else {
        emit(const HotelErrorState('Hotel not found.'));
      }
    } catch (e) {
      emit(const HotelErrorState('Failed to load hotel details.'));
    }
  }
}
