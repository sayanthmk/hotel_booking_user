import 'package:bloc/bloc.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

part 'selectedhotel_event.dart';
part 'selectedhotel_state.dart';

class SelectedHotelBloc extends Bloc<SelectedHotelEvent, SelectedHotelState> {
  SelectedHotelBloc() : super(SelectedHotelInitial()) {
    on<SelectHotelEvent>((event, emit) {
      emit(SelectedHotelLoaded(event.hotel));
    });
  }
}
