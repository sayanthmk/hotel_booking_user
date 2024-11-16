import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';

abstract class SelectedRoomState extends Equatable {
  const SelectedRoomState();

  @override
  List<Object?> get props => [];
}

class SelectedRoomInitial extends SelectedRoomState {}

class RoomSelected extends SelectedRoomState {
  final RoomEntity selectedRoom;

  const RoomSelected(this.selectedRoom);

  @override
  List<Object?> get props => [selectedRoom];
}
