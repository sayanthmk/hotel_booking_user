// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/rooms/data/model/rooms_model.dart';
// import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';

// abstract class HotelRoomsState {}

// class HotelRoomsInitial extends HotelRoomsState {}

// class HotelRoomsLoading extends HotelRoomsState {}

// class HotelRoomsLoaded extends HotelRoomsState {
//   final List<RoomEntity> rooms;
//   final HotelEntity hotel;
//   HotelRoomsLoaded(this.rooms, this.hotel);
// }

// class HotelRoomsError extends HotelRoomsState {
//   final String message;
//   HotelRoomsError(this.message);
// }

// abstract class HotelRoomsEvent {}

// class LoadHotelRoomsEvent extends HotelRoomsEvent {
//   final HotelEntity hotel;
//   LoadHotelRoomsEvent(this.hotel);
// }

// class HotelRoomsBloc extends Bloc<HotelRoomsEvent, HotelRoomsState> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   HotelRoomsBloc() : super(HotelRoomsInitial()) {
//     on<LoadHotelRoomsEvent>(_onLoadHotelRooms);
//   }

//   Future<void> _onLoadHotelRooms(
//     LoadHotelRoomsEvent event,
//     Emitter<HotelRoomsState> emit,
//   ) async {
//     try {
//       emit(HotelRoomsLoading());

//       // Use the hotel ID from the event instead of user ID
//       String hotelId =
//           event.hotel.hotelId; // Ensure hotel ID is available in HotelEntity
//       log('Fetching rooms for hotelId: $hotelId');

//       // Now use the hotelId to access the hotel's rooms collection
//       final roomsSnapshot = await _firestore
//           .collection('approved_hotels') // Collection for hotels
//           .doc(hotelId) // Document ID for the selected hotel
//           .collection('rooms') // Rooms collection inside the selected hotel
//           .get();

//       // Log the fetched rooms snapshot data
//       log('Fetched Rooms Snapshot: ${roomsSnapshot.docs.length} rooms found.');
//       roomsSnapshot.docs.forEach((doc) {
//         log('Room data: ${doc.data()}'); // Log each room's data
//       });

//       // Map the snapshot data to RoomModel
//       final rooms = roomsSnapshot.docs
//           .map((doc) => RoomModel.fromJson({...doc.data(), 'id': doc.id}))
//           .toList();

//       emit(HotelRoomsLoaded(rooms, event.hotel));
//     } catch (e) {
//       emit(HotelRoomsError('Failed to load rooms: ${e.toString()}'));
//     }
//   }
// }

// class HotelRoomsPage extends StatelessWidget {
//   final HotelEntity hotel;

//   const HotelRoomsPage({
//     super.key,
//     required this.hotel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HotelRoomsBloc()..add(LoadHotelRoomsEvent(hotel)),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('${hotel.hotelName} Rooms'),
//         ),
//         body: BlocBuilder<HotelRoomsBloc, HotelRoomsState>(
//           builder: (context, state) {
//             if (state is HotelRoomsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is HotelRoomsLoaded) {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: state.rooms.length,
//                 itemBuilder: (context, index) => Column(
//                   children: [
//                     const Text('hello'),
//                     _buildRoomCard(context, state.rooms[index]),
//                   ],
//                 ),
//               );
//             } else if (state is HotelRoomsError) {
//               return Center(child: Text(state.message));
//             }
//             return const Center(child: Text('No rooms available'));
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildRoomCard(BuildContext context, RoomEntity room) {
//     return Card(
//       child: ListTile(
//         title: Column(
//           children: [
//             Text(room.roomType),
//             // Text(room.basePrice as String),
//             Text(room.roomArea),
//             Text('${room.extraAdultsAllowed}'),
//           ],
//         ),
//         // subtitle: Text('Price: \$${room.basePrice}'),
//         // You can add more details like room images and description
//       ),
//     );
//   }
// }
