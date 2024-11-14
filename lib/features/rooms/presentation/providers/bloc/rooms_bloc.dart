import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/rooms/domain/usecase/rooms_usecase.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_event.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_state.dart';

class HotelRoomsBloc extends Bloc<HotelRoomsEvent, HotelRoomsState> {
  final GetHotelRoomsUseCase getHotelRoomsUseCase;

  HotelRoomsBloc({required this.getHotelRoomsUseCase})
      : super(HotelRoomsInitial()) {
    on<LoadHotelRoomsEvent>(_onLoadHotelRooms);
  }

  Future<void> _onLoadHotelRooms(
    LoadHotelRoomsEvent event,
    Emitter<HotelRoomsState> emit,
  ) async {
    try {
      emit(HotelRoomsLoading());
      final rooms = await getHotelRoomsUseCase.execute(event.hotel.hotelId);
      emit(HotelRoomsLoaded(rooms, event.hotel));
    } catch (e) {
      emit(HotelRoomsError('Failed to load rooms: ${e.toString()}'));
    }
  }
}
