import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/booking_det_card.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/booking_hotel_details.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/utils/alertbox.dart';

class BookingDetailPageSection extends StatelessWidget {
  const BookingDetailPageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.read<UserBloc>().add(GetUserDataEvent());
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: HotelBookingColors.basictextcolor,
              ),
            );
          }

          if (state is UserErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is SingleUserBookingLoadedState) {
            final booking = state.booking;
            // String startdate =
            //     DateFormat('dd MMM yyyy').format(booking.startdate);
            // String enddate = DateFormat('dd MMM yyyy').format(booking.enddate);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  BookingDetailPageCard(
                    booking: booking,

                    //  startdate: startdate, enddate: enddate
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (booking.id != null) {
                              // _showCancelDialog(context, booking);
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomAlertDialog(
                                      titleText: 'Cancel Booking',
                                      contentText:
                                          'Are you sure you want to cancel this booking? This action cannot be undone.',
                                      buttonText1: 'No, Keep it',
                                      buttonText2: 'Yes, Cancel',
                                      onPressButton1: () {
                                        Navigator.of(context).pop();
                                      },
                                      onPressButton2: () {
                                        context.read<UserBloc>().add(
                                              DeleteUserBookingEvent(
                                                  booking.id!,
                                                  booking.hotelId!),
                                            );
                                        Navigator.of(context).pop();
                                      }));
                            } else {
                              // _showErrorSnackBar(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "Booking ID is null, cannot delete."),
                                  backgroundColor: Colors.red[400],
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.cancel_outlined),
                          label: const Text('Cancel Booking'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HotelBookingDetailPage(
                                hotelId: booking.hotelId!,
                              ),
                            ));
                          },
                          icon: const Icon(Icons.hotel),
                          label: const Text('Hotel Details'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HotelBookingColors.basictextcolor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Unable to load booking details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

  // Widget _buildInfoSection(String label, String value, IconData icon) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(
  //         icon,
  //         size: 24,
  //         color: HotelBookingColors.basictextcolor,
  //       ),
  //       const SizedBox(width: 12),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               label,
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.grey[600],
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             const SizedBox(height: 4),
  //             Text(
  //               value,
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // void _showCancelDialog(BuildContext context, dynamic booking) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       title: Row(
  //         children: [
  //           Icon(
  //             Icons.warning_amber_rounded,
  //             color: Colors.red[400],
  //           ),
  //           const SizedBox(width: 8),
  //           const Text('Cancel Booking'),
  //         ],
  //       ),
  //       content: const Text(
  //         'Are you sure you want to cancel this booking? This action cannot be undone.',
  //         style: TextStyle(fontSize: 16),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text(
  //             'No, Keep it',
  //             style: TextStyle(color: Colors.grey),
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             context.read<UserBloc>().add(
  //                   DeleteUserBookingEvent(booking.id!, booking.hotelId!),
  //                 );
  //             Navigator.of(context).pop();
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.red[400],
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //           child: const Text('Yes, Cancel'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _showErrorSnackBar(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: const Text("Booking ID is null, cannot delete."),
  //       backgroundColor: Colors.red[400],
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //   );
  // }





// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/booking_hotel_details.dart';
// import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
// import 'package:intl/intl.dart';

// class BookingDetailPageSection extends StatelessWidget {
//   const BookingDetailPageSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Booking Details',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: HotelBookingColors.basictextcolor,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             context.read<UserBloc>().add(GetUserDataEvent());
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: BlocBuilder<UserBloc, UserState>(
//         builder: (context, state) {
//           if (state is UserLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is UserErrorState) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }

//           if (state is SingleUserBookingLoadedState) {
//             final booking = state.booking;
//             String startdate =
//                 DateFormat('dd/MM/yyyy').format(booking.startdate);
//             String enddate = DateFormat('dd/MM/yyyy').format(booking.enddate);
//             return Card(
//               elevation: 6,
//               margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white,
//                       Colors.blue.shade50,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'ID: ${booking.bookId!}'.substring(0, 14).toUpperCase(),
//                       ),
//                       Text(
//                         'Name:${booking.name}',
//                       ),
//                       Text(
//                         'startdate:$startdate',
//                       ),
//                       Text(
//                         'enddate:$enddate',
//                       ),
//                       Text(
//                         'No of Adults:${booking.noa}',
//                       ),
//                       Text(
//                         'No of Childs:${booking.noc}',
//                       ),
//                       Text(
//                         'Place:${booking.place}',
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Center(
//                             child: ElevatedButton.icon(
//                               onPressed: () {
//                                 if (booking.id != null) {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                       title: const Text(
//                                         'Cancel Booking',
//                                       ),
//                                       content: const Text(
//                                         'Are you sure you want to cancel this booking?',
//                                       ),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () =>
//                                               Navigator.of(context).pop(),
//                                           child: const Text('No'),
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             context.read<UserBloc>().add(
//                                                 DeleteUserBookingEvent(
//                                                     booking.id!,
//                                                     booking.hotelId!));
//                                             Navigator.of(context).pop();
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.blue,
//                                           ),
//                                           child: const Text('Yes, Cancel'),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           "Booking ID is null, cannot delete."),
//                                       backgroundColor: Colors.blue,
//                                     ),
//                                   );
//                                 }
//                               },
//                               icon: const Icon(
//                                 Icons.cancel_outlined,
//                                 color: Colors.white,
//                               ),
//                               label: const Text(
//                                 'Cancel Booking',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 10),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Center(
//                             child: ElevatedButton.icon(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => HotelBookingDetailPage(
//                                     hotelId: booking.hotelId!,
//                                   ),
//                                 ));
//                               },
//                               icon: const Icon(
//                                 Icons.details,
//                                 color: Colors.white,
//                               ),
//                               label: const Text(
//                                 'Hotel Details',
//                                 style: TextStyle(color: Colors.white),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 10),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }

//           return const Center(
//             child: Text('Unable to load booking details'),
//           );
//         },
//       ),
//     );
//   }
// }

// Widget buildBookingDetailRow({
//   required IconData icon,
//   required String label,
//   required String value,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4.0),
//     child: Row(
//       children: [
//         Icon(
//           icon,
//           color: Colors.blue.shade600,
//           size: 20,
//         ),
//         const SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey.shade700,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }


     // BlocProvider(
                      //   create: (context) => context.read<HotelBloc>(),
                      //   child: BlocBuilder<HotelBloc, HotelState>(
                      //     builder: (context, hotelState) {
                      //       if (hotelState is HotelInitial) {
                      //         context
                      //             .read<HotelBloc>()
                      //             .add(LoadHotelByIdEvent(booking.hotelId!));
                      //       }
                      //       if (hotelState is HotelLoadingState) {
                      //         return const Padding(
                      //           padding: EdgeInsets.all(16.0),
                      //           child: Center(
                      //             child: CircularProgressIndicator(),
                      //           ),
                      //         );
                      //       }
                      //       if (hotelState is HotelLoadedState) {
                      //         // final hotel = hotelState.hotels.firstWhere(
                      //         //   (hotel) =>
                      //         //       hotel.hotelId == booking.hotelId,
                      //         // );

                      //         final hotel = hotelState.hotels;
                      //         return Padding(
                      //           padding: const EdgeInsets.all(16.0),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 'Hotel Details:',
                      //                 style: TextStyle(
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.blue.shade800,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 'Hotel Name: ${hotel.first.bookingSince}',
                      //                 style: const TextStyle(fontSize: 14),
                      //               ),
                      //               Text(
                      //                 'Location: ${hotel}',
                      //                 style: const TextStyle(fontSize: 14),
                      //               ),
                      //               // Text(
                      //               //   'Amenities: ${hotel.amenities.join(', ')}',
                      //               //   style: const TextStyle(fontSize: 14),
                      //               // ),
                      //             ],
                      //           ),
                      //         );
                      //         // return const Text('Hotel details not available.');
                      //       }
                      //       if (hotelState is HotelErrorState) {
                      //         return Text(
                      //           'Error: ${hotelState.message}',
                      //           style: const TextStyle(color: Colors.red),
                      //         );
                      //       }
                      //       return const SizedBox.shrink();
                      //     },
                      //   ),
                      // ),
                      // BlocProvider(
                      //   create: (context) => context.read<HotelBloc>(),
                      //   child: BlocBuilder<HotelBloc, HotelState>(
                      //     builder: (context, hotelState) {
                      //       if (hotelState is HotelInitial) {
                      //         context
                      //             .read<HotelBloc>()
                      //             .add(LoadHotelByIdEvent(booking.hotelId!));
                      //       }
                      //       if (hotelState is HotelLoadingState) {
                      //         return const Padding(
                      //           padding: EdgeInsets.all(16.0),
                      //           child: Center(
                      //             child: CircularProgressIndicator(),
                      //           ),
                      //         );
                      //       }
                      //       if (hotelState is HotelLoadedState) {
                      //         final hotel = hotelState.hotels.firstWhere(
                      //           (hotel) => hotel.hotelId == booking.hotelId,
                      //         );
                      //         // final hotel=hotelState.hotels
                      //         return Padding(
                      //           padding: const EdgeInsets.all(16.0),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 'Hotel Details:',
                      //                 style: TextStyle(
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.blue.shade800,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 'Hotel Name: ${hotel.hotelName}',
                      //                 style: const TextStyle(fontSize: 14),
                      //               ),
                      //               Text(
                      //                 'Location: ${hotel.country}',
                      //                 style: const TextStyle(fontSize: 14),
                      //               ),
                      //               // Text(
                      //               //   'Amenities: ${hotel.amenities.join(', ')}',
                      //               //   style: const TextStyle(fontSize: 14),
                      //               // ),
                      //             ],
                      //           ),
                      //         );
                      //         // return const Text('Hotel details not available.');
                      //       }
                      //       if (hotelState is HotelErrorState) {
                      //         return Text(
                      //           'Error: ${hotelState.message}',
                      //           style: const TextStyle(color: Colors.red),
                      //         );
                      //       }
                      //       return const SizedBox.shrink();
                      //     },
                      //   ),
                      // ),
//                       import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';


   // InkWell(
                      //   onTap: () {
                      //       final hotel = booking.hotelId!;
                      //     context
                      //         .read<SelectedHotelBloc>()
                      //         .add(SelectHotelEvent(hotel));
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const HotelDetailPage(),
                      //       ),
                      //     );
                      //   },
                      //   child: Card(
                      //     child: Container(
                      //       height: 100,
                      //       width: 250,
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20)),
                      //       child: Column(
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Container(
                      //               height: 140,
                      //               width: 250,
                      //               decoration: BoxDecoration(
                      //                 image: DecorationImage(
                      //                   fit: BoxFit.fill,
                      //                   image: NetworkImage(
                      //                     hotel.images[0],
                      //                   ),
                      //                 ),
                      //                 color: Colors.grey,
                      //                 borderRadius: BorderRadius.circular(20),
                      //               ),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   hotel.hotelName,
                      //                   style: const TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 22),
                      //                 ),
                      //                 Text(
                      //                   ' ₹${hotel.propertySetup}/night',
                      //                   style: const TextStyle(
                      //                       color: HotelBookingColors
                      //                           .basictextcolor,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 14),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 SizedBox(
                      //                   child: Row(
                      //                     children: [
                      //                       Icon(
                      //                         Icons.location_on,
                      //                         color: Colors.red[600],
                      //                       ),
                      //                       Text(
                      //                         '${hotel.city}/${hotel.state}',
                      //                         style: TextStyle(
                      //                             color: Colors.grey[500],
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Text(hotel.hotelType),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                      
                      // Text(
                      //   'Name:${booking.name}',
                      // ),
                      // Text(
                      //   ':${booking.name}',
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Name:${booking.name}',
                      //       // style: TextStyle(
                      //       //   fontSize: 20,
                      //       //   fontWeight: FontWeight.bold,
                      //       //   color: Colors.blue.shade800,
                      //       // ),
                      //     ),
                      //     Icon(
                      //       Icons.hotel,
                      //       color: Colors.blue.shade600,
                      //       size: 30,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 12),
                      // buildBookingDetailRow(
                      //   icon: Icons.calendar_today,
                      //   label: 'Check-in',
                      //   value: startdate,
                      // ),
                      // buildBookingDetailRow(
                      //   icon: Icons.calendar_month,
                      //   label: 'Check-out',
                      //   value: enddate,
                      // ),
                      // const Divider(height: 20, thickness: 1),
                      // buildBookingDetailRow(
                      //   icon: Icons.person,
                      //   label: 'Name',
                      //   value: booking.name,
                      // ),
                      // buildBookingDetailRow(
                      //   icon: Icons.group,
                      //   label: 'Adults',
                      //   value:
                      //       'Adults: ${booking.noa}, Children: ${booking.noc}',
                      // ),

                            // TextButton.icon(
                      //     onPressed: () {}, label: Text('Show Hotel Details'))
                      // Text(booking.hotelId!),
                      // InkWell(
                      //   onTap: () {
                      //     final hotelId = booking.hotelId!;
                      //     context
                      //         .read<HotelBloc>()
                      //         .add(LoadHotelByIdEvent(hotelId));
                      //     showDialog(
                      //       context: context,
                      //       builder: (context) =>
                      //           BlocBuilder<HotelBloc, HotelState>(
                      //         builder: (context, hotelState) {
                      //           if (hotelState is HotelLoadingState) {
                      //             return const Center(
                      //               child: CircularProgressIndicator(),
                      //             );
                      //           }
                      //           if (hotelState is HotelErrorState) {
                      //             return AlertDialog(
                      //               title: const Text('Error'),
                      //               content: Text(hotelState.message),
                      //               actions: [
                      //                 TextButton(
                      //                   onPressed: () =>
                      //                       Navigator.of(context).pop(),
                      //                   child: const Text('Close'),
                      //                 ),
                      //               ],
                      //             );
                      //           }
                      //           if (hotelState is HotelDetailLoadedState) {
                      //             final hotel = hotelState.hotel;
                      //             return AlertDialog(
                      //               title: Text(hotel.hotelName),
                      //               content: Column(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text('Location: ${hotel.city}'),
                      //                   // Text('Amenities: ${hotel.amenities.join(', ')}'),
                      //                   Text('hotel name: ${hotel.hotelName}'),
                      //                   // Text('Rating: ${hotel.rating.toStringAsFixed(1)}'),
                      //                   Text('Hotel Type: ${hotel.hotelType}'),
                      //                   // Text('Type: ${hotel.country}'),
                      //                   // Text('Type: ${hotel.country}'),
                      //                 ],
                      //               ),
                      //               actions: [
                      //                 TextButton(
                      //                   onPressed: () =>
                      //                       Navigator.of(context).pop(),
                      //                   child: const Text('Close'),
                      //                 ),
                      //               ],
                      //             );
                      //           }

                      //           return const Center(
                      //             child: Text('Something went wrong'),
                      //           );
                      //         },
                      //       ),
                      //     );
                      //   },
                      //   child: const Center(
                      //     child: Text('Show Hotel Details'),
                      //   ),
                      // ),