import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';

abstract class SelectedRoomEvent extends Equatable {
  const SelectedRoomEvent();

  @override
  List<Object?> get props => [];
}

class SelectRoomEvent extends SelectedRoomEvent {
  final RoomEntity room;

  const SelectRoomEvent(this.room);

  @override
  List<Object?> get props => [room];
}

class ClearSelectedRoomEvent extends SelectedRoomEvent {}
