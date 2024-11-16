import 'package:bloc/bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_event.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';

class SelectedRoomBloc extends Bloc<SelectedRoomEvent, SelectedRoomState> {
  SelectedRoomBloc() : super(SelectedRoomInitial()) {
    on<SelectRoomEvent>((event, emit) {
      emit(RoomSelected(event.room));
    });

    on<ClearSelectedRoomEvent>((event, emit) {
      emit(SelectedRoomInitial());
    });
  }
}
