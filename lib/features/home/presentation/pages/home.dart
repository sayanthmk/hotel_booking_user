import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_state.dart';

class HotelListPage extends StatelessWidget {
  const HotelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel List'),
      ),
      body: BlocProvider(
        create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
        child: BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            if (state is HotelLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelLoadedState) {
              // log('${state.hotels.length}');
              return ListView.builder(
                itemCount: state.hotels.length,
                itemBuilder: (context, index) {
                  // log('hello');
                  HotelEntity hotel = state.hotels[index];
                  return Column(
                    children: [
                      Text('${hotel.pincode}'),
                      Text(hotel.city),
                      Text(hotel.hotelType),
                      Text(hotel.hotelName),
                      Text(hotel.bookingSince),
                      Text(hotel.contactNumber),
                      Text(hotel.emailAddress),
                      Text(hotel.city),
                      Text(hotel.state),
                      Text(hotel.country),
                      const Text('\n')
                    ],
                  );
                },
              );
            } else if (state is HotelErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: Text('No hotels found'));
          },
        ),
      ),
    );
  }
}

// class HomeListView extends StatelessWidget {
//   const HomeListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel List'),
//       ),
//       body: BlocProvider(
//         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         child: BlocBuilder<HotelBloc, HotelState>(
//           builder: (context, state) {
//             if (state is HotelLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is HotelLoadedState) {
//               return SizedBox(
//                 height: 250,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal, // Set horizontal scrolling
//                   itemCount: state.hotels.length,
//                   itemBuilder: (context, index) {
//                     HotelEntity hotel = state.hotels[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                         width: 200, // Set a fixed width for horizontal layout
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 6,
//                               offset: const Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => const HotelDetailPage(),
//                             ));
//                           },
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 140,
//                                 decoration: const BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     topRight: Radius.circular(20),
//                                   ),
//                                   color: Colors.blueGrey,
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     topRight: Radius.circular(20),
//                                   ),
//                                   child: Image.asset(
//                                     'assets/images/hotel_image.jpg',
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 hotel.hotelName,
//                                                 style: const TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 4),
//                                               Text(
//                                                 '${hotel.city}, ${hotel.state}',
//                                                 style: TextStyle(
//                                                   color: Colors.grey[600],
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 12,
//                                             vertical: 6,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.indigo,
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: const Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.star,
//                                                 size: 16,
//                                                 color: Colors.white,
//                                               ),
//                                               SizedBox(width: 4),
//                                               Text(
//                                                 '4.5',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.hotel,
//                                             color: Colors.grey[600]),
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           hotel.hotelType,
//                                           style: TextStyle(
//                                               color: Colors.grey[600]),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.access_time,
//                                             color: Colors.grey[600]),
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           'Booking since ${hotel.bookingSince}',
//                                           style: TextStyle(
//                                               color: Colors.grey[600]),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 16),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Text(
//                                               'Price per night',
//                                               style: TextStyle(
//                                                 color: Colors.grey,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 const Text(
//                                                   '₹2000',
//                                                   style: TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color(0xFF1E91B6),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 8),
//                                                 Text(
//                                                   '₹3000',
//                                                   style: TextStyle(
//                                                     decoration: TextDecoration
//                                                         .lineThrough,
//                                                     color: Colors.grey[600],
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             // Handle booking action
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 const Color(0xFF1E91B6),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             'Book Now',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             } else if (state is HotelErrorState) {
//               return Center(
//                 child: Text(
//                   state.message,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               );
//             }
//             return const Center(child: Text('No hotels found'));
//           },
//         ),
//       ),
//     );
//   }
// }
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/utils/alertbox.dart';
// import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
// import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Center(
//             child: Text('Welcome to the Home Page!'),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return CustomAlertDialog(
//                     titleText: 'Delete',
//                     contentText: 'Are you sure want to Logout?',
//                     buttonText1: 'Cancel',
//                     buttonText2: 'Logout',
//                     onPressButton1: () {
//                       Navigator.of(context).pop();
//                     },
//                     onPressButton2: () {
//                       log('Action 2 executed');
//                       context.read<AuthBloc>().add(SignOutEvent());
//                       log('Logout button pressed');
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (context) => const AuthSelectionPage(),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// lib/presentation/pages/hotel_list_page.dart