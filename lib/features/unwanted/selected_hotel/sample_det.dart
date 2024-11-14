// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/pages/sample_page.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

// class HotelDetailsPage extends StatelessWidget {
//   const HotelDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel Details'),
//       ),
//       body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
//         builder: (context, state) {
//           if (state is SelectedHotelLoaded) {
//             final hotel = state.hotel;
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Hotel Image (if available)
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Center(
//                       child: Icon(Icons.hotel, size: 50),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Hotel Name
//                   Text(
//                     hotel.hotelName,
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   const SizedBox(height: 8),

//                   // Hotel ID
//                   Text(
//                     'Hotel ID: ${hotel.emailAddress}',
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: Colors.grey[600],
//                         ),
//                   ),
//                   const SizedBox(height: 16),
//                   // HotelInfoWidgetPage(),
//                   // Add more hotel details here as needed
//                   // Example:
//                   // - Description
//                   // - Amenities
//                   // - Rating
//                   // - Price
//                   // - Location
//                   // - Contact Information

//                   // Booking Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Implement booking functionality
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text('Book Now'),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Implement booking functionality
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const HotelInfoWidget(),
//                         ));
//                       },
//                       child: const Text('name'),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return const Center(child: Text('Please Select Hotel'));
//         },
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_bloc.dart';
// // import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_state.dart';

// // class HotelDetailPage extends StatelessWidget {
// //   final String hotelId;

// //   const HotelDetailPage({super.key, required this.hotelId});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Hotel Details'),
// //       ),
// //       body: BlocBuilder<HotelBloc, HotelState>(
// //         builder: (context, state) {
// //           if (state is HotelLoadingState) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (state is HotelDetailLoadedState) {
// //             final hotel = state.hotel;
// //             return Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('Name: ${hotel.hotelName}',
// //                       style: const TextStyle(
// //                           fontSize: 20, fontWeight: FontWeight.bold)),
// //                   const SizedBox(height: 8),
// //                   Text('Type: ${hotel.hotelType}'),
// //                   const SizedBox(height: 8),
// //                   Text('City: ${hotel.city}'),
// //                   const SizedBox(height: 8),
// //                   Text('State: ${hotel.state}'),
// //                   const SizedBox(height: 8),
// //                   Text('Country: ${hotel.country}'),
// //                   const SizedBox(height: 8),
// //                   Text('Contact: ${hotel.contactNumber}'),
// //                   const SizedBox(height: 8),
// //                   Text('Email: ${hotel.emailAddress}'),
// //                   const SizedBox(height: 8),
// //                   // Display more details about the hotel here
// //                 ],
// //               ),
// //             );
// //           } else if (state is HotelErrorState) {
// //             return Center(child: Text(state.message));
// //           } else {
// //             return const Center(child: Text('No details available.'));
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// // selected_hotel_state.dart
// // abstract class SelectedHotelState {}

// // class SelectedHotelInitial extends SelectedHotelState {}

// // class SelectedHotelLoaded extends SelectedHotelState {
// //   final HotelEntity hotel;
// //   SelectedHotelLoaded(this.hotel);
// // }

// // // selected_hotel_event.dart
// // abstract class SelectedHotelEvent {}

// // class SelectHotelEvent extends SelectedHotelEvent {
// //   final HotelEntity hotel;
// //   SelectHotelEvent(this.hotel);
// // }

// // class SelectedHotelBloc extends Bloc<SelectedHotelEvent, SelectedHotelState> {
// //   SelectedHotelBloc() : super(SelectedHotelInitial()) {
// //     on<SelectHotelEvent>((event, emit) {
// //       emit(SelectedHotelLoaded(event.hotel));
// //     });
// //   }
// // }