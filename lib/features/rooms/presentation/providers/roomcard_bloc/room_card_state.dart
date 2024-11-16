part of 'room_card_bloc.dart';

abstract class RoomCardState extends Equatable {
  @override
  List<Object> get props => [];
}

class RoomCardInitial extends RoomCardState {}

class RoomCardLoading extends RoomCardState {}

class RoomCardLoaded extends RoomCardState {
  final RoomEntity room;

  RoomCardLoaded(this.room);

  @override
  List<Object> get props => [room];
}

class RoomCardError extends RoomCardState {
  final String message;

  RoomCardError(this.message);

  @override
  List<Object> get props => [message];
}
