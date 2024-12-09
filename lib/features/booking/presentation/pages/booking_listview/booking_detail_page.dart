import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_list_main_page/bookings.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:intl/intl.dart';

class BookingDetailPageSection extends StatelessWidget {
  const BookingDetailPageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<UserBloc>().add(GetUserDataEvent());
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: const Text('Booking Details'),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           context.read<UserBloc>().add(GetUserDataEvent());
      //           Navigator.pop(context);
      //         },
      //         icon: const Icon(Icons.abc_sharp))
      //   ],
      // ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is SingleUserBookingLoadedState) {
            final booking = state.booking;
            String startdate =
                DateFormat('dd/MM/yyyy').format(booking.startdate);
            String enddate = DateFormat('dd/MM/yyyy').format(booking.enddate);
            return Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                booking.id!, booking.hotelId!));
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
                              ScaffoldMessenger.of(context).showSnackBar(
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
            );
          }

          return const Center(
            child: Text('Unable to load booking details'),
          );
        },
      ),
    );
  }
}





//  ElevatedButton(
//                       onPressed: () {
//                         if (booking.id != null) {
//                           context.read<UserBloc>().add(DeleteUserBookingEvent(
//                               booking.id!, booking.hotelId!));
//                           Navigator.pop(context);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content:
//                                     Text("Booking ID is null, cannot delete.")),
//                           );
//                         }
//                       },
//                       child: const Text('Cancel Booking'),
//                     ),