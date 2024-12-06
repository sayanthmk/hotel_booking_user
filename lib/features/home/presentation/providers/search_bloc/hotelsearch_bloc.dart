import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hotelsearch_event.dart';
part 'hotelsearch_state.dart';

class HotelsearchBloc extends Bloc<HotelsearchEvent, HotelsearchState> {
  HotelsearchBloc() : super(HotelsearchInitial()) {
    on<HotelsearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
