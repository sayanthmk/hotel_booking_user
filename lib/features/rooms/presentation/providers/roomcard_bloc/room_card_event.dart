part of 'room_card_bloc.dart';

abstract class RoomCardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRoomEvent extends RoomCardEvent {
  final RoomEntity room;

  LoadRoomEvent(this.room);

  @override
  List<Object> get props => [room];
}
