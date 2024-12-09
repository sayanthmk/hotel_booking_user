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
  // Widget buildBookingsList(List<UserDataModel> bookings) {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(16),
  //     itemCount: bookings.length,
  //     itemBuilder: (context, index) {
  //       final booking = bookings[index];
  //       return InkWell(
  //         onTap: () {},
  //         child: Card(
  //           elevation: 4,
  //           margin: const EdgeInsets.symmetric(vertical: 8),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Booked start: ${booking.startdate}',
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //                 Text(
  //                   'Booked end: ${booking.enddate}',
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       booking.name,
  //                       style: const TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     Text(
  //                       'Age: ${booking.age}',
  //                       style: const TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Place: ${booking.place}',
  //                       style: const TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //                 if (booking.id != null)
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 8.0),
  //                     child: Text(
  //                       'Booking ID: ${booking.id}',
  //                       style: const TextStyle(
  //                         fontSize: 12,
  //                         color: Colors.black54,
  //                       ),
  //                     ),
  //                   ),
  //                 TextButton(
  //                   onPressed: () {
  //                     if (booking.id != null) {
  //                       context
  //                           .read<UserBloc>()
  //                           .add(DeleteUserBookingEvent(booking.id!));
  //                     } else {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                             content:
  //                                 Text("Booking ID is null, cannot delete.")),
  //                       );
  //                     }
  //                   },
  //                   child: const Text('Delete'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //       // return buildBookingCard(bookings[index]);
  //     },
  //   );
  // }
   // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       booking.name,
                          //       style: const TextStyle(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     Text(
                          //       'Age: ${booking.age}',
                          //       style: const TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.grey,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height: 8),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Place: ${booking.place}',
                          //       style: const TextStyle(fontSize: 16),
                          //     ),
                          //   ],
                          // ),
                          // if (booking.id != null)
                          //   Padding(
                          //     padding: const EdgeInsets.only(top: 8.0),
                          //     child: Text(
                          //       'Booking ID: ${booking.id}',
                          //       style: const TextStyle(
                          //         fontSize: 12,
                          //         color: Colors.black54,
                          //       ),
                          //     ),
                          //   ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: Text(
                          //     'Booking ID: ${booking.bookId}',
                          //     style: const TextStyle(
                          //       fontSize: 12,
                          //       color: Colors.black54,
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: Text(
                          //     'Room ID: ${booking.cuid}',
                          //     style: const TextStyle(
                          //       fontSize: 12,
                          //       color: Colors.black54,
                          //     ),
                          //   ),
                          // ),
                            // Widget buildErrorView(BuildContext context, String errorMessage) {
  //   log(errorMessage);
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Icon(
  //           Icons.error_outline,
  //           color: Colors.red,
  //           size: 60,
  //         ),
  //         const SizedBox(height: 16),
  //         Text(
  //           'Error Loading Bookings',
  //           style: Theme.of(context).textTheme.titleLarge,
  //         ),
  //         Text(
  //           errorMessage,
  //           style: Theme.of(context).textTheme.bodyMedium,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: 16),
  //         ElevatedButton(
  //           onPressed: () {
  //             context.read<UserBloc>().add(GetUserDataEvent());
  //           },
  //           child: const Text('Retry'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildEmptyBookingsView() {
  //   return const Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(
  //           Icons.bookmark_border,
  //           size: 80,
  //           color: Colors.grey,
  //         ),
  //         SizedBox(height: 16),
  //         Text(
  //           'No Bookings Yet',
  //           style: TextStyle(
  //             fontSize: 18,
  //             color: Colors.grey,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildBookingCard(
  //   UserDataModel booking,
  // ) {
  //   return InkWell(
  //     onTap: () {},
  //     child: Card(
  //       elevation: 4,
  //       margin: const EdgeInsets.symmetric(vertical: 8),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Booked start: ${booking.startdate}',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //             Text(
  //               'Booked end: ${booking.enddate}',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   booking.name,
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   'Age: ${booking.age}',
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 8),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Place: ${booking.place}',
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //               ],
  //             ),
  //             if (booking.id != null)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 8.0),
  //                 child: Text(
  //                   'Booking ID: ${booking.id}',
  //                   style: const TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.black54,
  //                   ),
  //                 ),
  //               ),
  //             // TextButton(
  //             //     onPressed: () {
  //             //       context
  //             //           .read<UserBloc>()
  //             //           .add(DeleteUserBookingEvent(booking.id!));
  //             //     },
  //             //     child: Text('delete'))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }