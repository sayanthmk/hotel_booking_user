import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/domain/usecase/get_hotels_usecase.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final FetchHotelsUseCase fetchHotelsUseCase;

  HotelBloc(this.fetchHotelsUseCase) : super(HotelInitialState()) {
    on<LoadHotelsEvent>(_onLoadHotels);
  }

  Future<void> _onLoadHotels(
      LoadHotelsEvent event, Emitter<HotelState> emit) async {
    emit(HotelLoadingState());
    try {
      final List<HotelEntity> hotels = await fetchHotelsUseCase();
      emit(HotelLoadedState(hotels));
    } catch (e) {
      emit(HotelErrorState(e.toString()));
    }
  }
}
