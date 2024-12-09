import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:intl/intl.dart';

class UserBookingsPage extends StatelessWidget {
  const UserBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(GetUserDataEvent());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 0,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    HotelBookingColors.basictextcolor),
              ),
            );
          }

          if (state is UserErrorState) {
            return Text(state.message);
          }

          if (state is UserDataLoadedState) {
            if (state.userData.isEmpty) {
              // return buildEmptyBookingsView();
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No Bookings Yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.userData.length,
              itemBuilder: (context, index) {
                final booking = state.userData[index];
                String startdate =
                    DateFormat('dd/MM/yyyy').format(booking.startdate);
                String enddate =
                    DateFormat('dd/MM/yyyy').format(booking.enddate);
                return InkWell(
                    onTap: () {
                      final bookingId = booking.id!;
                      context
                          .read<UserBloc>()
                          .add(GetSingleUserBookingEvent(bookingId));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BookingDetailPageSection()),
                      );
                    },
                    child: Card(
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.blue.shade50,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    booking.place,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                  Icon(
                                    Icons.hotel,
                                    color: Colors.blue.shade600,
                                    size: 30,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              buildBookingDetailRow(
                                icon: Icons.calendar_today,
                                label: 'Check-in',
                                value: startdate,
                              ),
                              buildBookingDetailRow(
                                icon: Icons.calendar_month,
                                label: 'Check-out',
                                value: enddate,
                              ),
                              const Divider(height: 20, thickness: 1),
                              buildBookingDetailRow(
                                icon: Icons.person,
                                label: 'Name',
                                value: booking.name,
                              ),
                              buildBookingDetailRow(
                                icon: Icons.group,
                                label: 'Adults',
                                value:
                                    'Adults: ${booking.noa}, Children: ${booking.noc}',
                              ),
                              const SizedBox(height: 12),
                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (booking.id != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Cancel Booking',
                                          ),
                                          content: const Text(
                                            'Are you sure you want to cancel this booking?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('No'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<UserBloc>().add(
                                                    DeleteUserBookingEvent(
                                                        booking.id!,
                                                        booking.hotelId!));
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text('Yes, Cancel'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Booking ID is null, cannot delete."),
                                          backgroundColor: Colors.blue,
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Cancel Booking',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

// Helper method to create consistent booking detail rows

                    // child: Card(
                    //   elevation: 4,
                    //   margin: const EdgeInsets.symmetric(vertical: 8),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'Booked started: ${booking.startdate}',
                    //         ),
                    //         Text(
                    //           'Booked end: ${booking.enddate}',
                    //         ),
                    //         Text(
                    //           'Place: ${booking.place}',
                    //         ),
                    //         Text(
                    //           'name: ${booking.name}',
                    //         ),
                    //         Text(
                    //           'age: ${booking.age}',
                    //         ),
                    //         Text(
                    //           'no of childerns: ${booking.noc}',
                    //         ),
                    //         Text(
                    //           'no of adults: ${booking.noa}',
                    //         ),
                    //         TextButton(
                    //           onPressed: () {
                    //             if (booking.id != null) {
                    //               context.read<UserBloc>().add(
                    //                   DeleteUserBookingEvent(
                    //                       booking.id!, booking.hotelId!));
                    //             } else {
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //                 const SnackBar(
                    //                     content: Text(
                    //                         "Booking ID is null, cannot delete.")),
                    //               );
                    //             }
                    //           },
                    //           child: const Text('Cancel Booking'),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    );
              },
            );
          }

          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}

Widget buildBookingDetailRow({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.blue.shade600,
          size: 20,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}



      // Text(
                          //   'Room Id: ${booking.roomId}',
                          // ),
                          // Text(
                          //   'Hotel Id: ${booking.hotelId}',
                          // ),
                          // Text(
                          //   'Booking Id: ${booking.bookId}',
                          // ),
                                 // context.read<UserBloc>().add(
                                //       DeleteHotelBookingEvent(
                                //         hotelId: booking.id!,
                                //         bookingId: booking.bookId!,
                                //       ),
                                //     );