// // InkWell(
// //   onTap: () {
// //     context.read<SelectedHotelBloc>().add(SelectHotelEvent(hotel));
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => const HotelDetailPage(),
// //       ),
// //     );
// //   },
// //   child: Container(
// //     width: 220,
// //     decoration: BoxDecoration(
// //       borderRadius: BorderRadius.circular(16),
// //       boxShadow: [
// //         BoxShadow(
// //           color: Colors.black.withOpacity(0.1),
// //           blurRadius: 10,
// //           offset: Offset(0, 5),
// //         ),
// //       ],
// //     ),
// //     child: ClipRRect(
// //       borderRadius: BorderRadius.circular(16),
// //       child: Stack(
// //         children: [
// //           // Background Image
// //           Container(
// //             height: 280,
// //             width: 220,
// //             decoration: BoxDecoration(
// //               image: DecorationImage(
// //                 image: NetworkImage(hotel.images[0]),
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),

// //           // Gradient Overlay
// //           Container(
// //             height: 280,
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //                 colors: [
// //                   Colors.transparent,
// //                   Colors.black.withOpacity(0.7),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           // Heart Icon
// //           Positioned(
// //             top: 15,
// //             right: 15,
// //             child: Container(
// //               padding: EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 shape: BoxShape.circle,
// //               ),
// //               child: Icon(
// //                 Icons.favorite,
// //                 color: Colors.red,
// //                 size: 20,
// //               ),
// //             ),
// //           ),

// //           // Content
// //           Positioned(
// //             bottom: 20,
// //             left: 20,
// //             right: 20,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   hotel.hotelName,
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 SizedBox(height: 5),
// //                 Text(
// //                   '${hotel.city}, ${hotel.state}',
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     color: Colors.white70,
// //                   ),
// //                 ),
// //                 SizedBox(height: 10),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(
// //                       '₹${hotel.propertySetup}/night',
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w600,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                     Row(
// //                       children: [
// //                         Icon(
// //                           Icons.star,
// //                           color: Colors.amber,
// //                           size: 16,
// //                         ),
// //                         SizedBox(width: 4),
// //                         Text(
// //                           hotel.rating?.toStringAsFixed(1) ?? "4.5",
// //                           style: TextStyle(
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.w500,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   ),
// // )
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/widgets/hote_shimmer.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

// class HotelsListView extends StatelessWidget {
//   const HotelsListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
//           if (state is HotelLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//             // return const HotelCardShimmerSection();
//           } else if (state is HotelLoadedState) {
//             return SizedBox(
//               height: 260,
//               child: Material(
//                 color: HotelBookingColors.pagebackgroundcolor,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: state.hotels.length,
//                     itemBuilder: (context, index) {
//                       HotelEntity hotel = state.hotels[index];
//                       return InkWell(
//                         onTap: () {
//                           context
//                               .read<SelectedHotelBloc>()
//                               .add(SelectHotelEvent(hotel));
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => const HotelDetailPage(),
//                           //   ),
//                           // );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Container(
//                             width: 220,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 10,
//                                   offset: Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: Stack(
//                                 children: [
//                                   // Background Image
//                                   Container(
//                                     height: 280,
//                                     width: 220,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         image: NetworkImage(hotel.images[0]),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),

//                                   // Gradient Overlay
//                                   Container(
//                                     height: 280,
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.transparent,
//                                           Colors.black.withOpacity(0.7),
//                                         ],
//                                       ),
//                                     ),
//                                   ),

//                                   // Heart Icon
//                                   Positioned(
//                                     top: 15,
//                                     right: 15,
//                                     child: Container(
//                                       padding: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Icon(
//                                         Icons.favorite,
//                                         color: Colors.red,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ),

//                                   // Content
//                                   Positioned(
//                                     bottom: 20,
//                                     left: 20,
//                                     right: 20,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           hotel.hotelName,
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         SizedBox(height: 5),
//                                         Text(
//                                           '${hotel.city}, ${hotel.state}',
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.white70,
//                                           ),
//                                         ),
//                                         SizedBox(height: 10),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               '₹${hotel.propertySetup}/night',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.star,
//                                                   color: Colors.amber,
//                                                   size: 16,
//                                                 ),
//                                                 SizedBox(width: 4),
//                                                 Text(
//                                                   "4.5",
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               ),
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
