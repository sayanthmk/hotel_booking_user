// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_state.dart';

// class TestListView extends StatelessWidget {
//   const TestListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
//           if (state is HotelLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is HotelLoadedState) {
//             return SizedBox(
//               height: 250,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal, // Set horizontal scrolling
//                   itemCount: state.hotels.length,
//                   itemBuilder: (context, index) {
//                     HotelEntity hotel = state.hotels[index];
//                     return InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const HotelDetailPage(),
//                         ));
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Container(
//                           width: 200,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 spreadRadius: 2,
//                                 blurRadius: 6,
//                                 offset: const Offset(2, 2),
//                               ),
//                             ],
//                           ),
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Center(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.blueGrey,
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   clipBehavior: Clip.antiAlias,
//                                   height: 140,
//                                   width: 180,
//                                   child: Image.asset(
//                                     'assets/images/hotel_image.jpg',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       hotel.hotelName,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${hotel.city}, ${hotel.state}',
//                                       style: const TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 130, 125, 125),
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Row(
//                                       children: [
//                                         Text(
//                                           '₹2000',
//                                           style: TextStyle(
//                                             color: Color(0xFF1E91B6),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(width: 5),
//                                         Text(
//                                           '3000',
//                                           style: TextStyle(
//                                             decoration:
//                                                 TextDecoration.lineThrough,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const Icon(
//                                       Icons.star,
//                                       size: 15,
//                                       color: Colors.yellow,
//                                     ),
//                                     Container(
//                                       height: 20,
//                                       width: 30,
//                                       decoration: BoxDecoration(
//                                         color: Colors.indigo,
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           '3.5',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 13,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             );
//           } else if (state is HotelErrorState) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }
//           return const Center(child: Text('No hotels found'));
//         }));
//   }
// }
