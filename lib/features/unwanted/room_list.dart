// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
// import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
// import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_event.dart';
// import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_state.dart';

// // lib/features/rooms/presentation/pages/hotel_rooms_page.dart
// class NewHotelRoomsPage extends StatelessWidget {
//   final HotelEntity hotel;

//   const NewHotelRoomsPage({
//     Key? key,
//     required this.hotel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           sl<HotelRoomsBloc>()..add(LoadHotelRoomsEvent(hotel)),
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
//                 itemBuilder: (context, index) => RoomCard(
//                   room: state.rooms[index],
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
// }

// class RoomCard extends StatelessWidget {
//   final RoomEntity room;

//   const RoomCard({Key? key, required this.room}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(room.roomType, style: Theme.of(context).textTheme.titleMedium),
//             const SizedBox(height: 8),
//             Text('Area: ${room.roomArea}',
//                 style: Theme.of(context).textTheme.bodyMedium),
//             Text('Extra Adults: ${room.extraAdultsAllowed}',
//                 style: Theme.of(context).textTheme.bodyMedium),
//             Text('Price: \$${room.basePrice}',
//                 style: Theme.of(context).textTheme.bodyLarge),
//           ],
//         ),
//       ),
//     );
//   }
// }
