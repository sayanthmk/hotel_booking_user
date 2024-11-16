import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';

part 'room_card_event.dart';
part 'room_card_state.dart';

class RoomCardBloc extends Bloc<RoomCardEvent, RoomCardState> {
  RoomCardBloc() : super(RoomCardInitial()) {
    on<LoadRoomEvent>((event, emit) async {
      emit(RoomCardLoading());
      try {
        // Simulating potential delay for future network calls or data transformations.
        await Future.delayed(const Duration(milliseconds: 200));
        emit(RoomCardLoaded(event.room));
      } catch (e) {
        emit(RoomCardError('Failed to load room details.'));
      }
    });
  }
}
