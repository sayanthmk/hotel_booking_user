import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';

class UserBookingsPage extends StatelessWidget {
  const UserBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(GetUserDataEvent());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 0,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh, color: Colors.white),
        //     onPressed: () {
        //       context.read<UserBloc>().add(GetUserDataEvent());
        //     },
        //   ),
        // ],
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
            // return buildErrorView(context, state.message);
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

            // return buildBookingsList(state.userData);
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.userData.length,
              itemBuilder: (context, index) {
                final booking = state.userData[index];
                return InkWell(
                  // onTap: () {},
                  onTap: () {
                    final bookingId =
                        booking.id!; // Ensure booking.id is not null
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
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booked start: ${booking.startdate}',
                          ),
                          Text(
                            'Booked end: ${booking.enddate}',
                          ),
                          Text(
                            'Place: ${booking.place}',
                          ),
                          // Text(
                          //   'Id : ${booking.id}',
                          // ),
                          Text(
                            'name: ${booking.name}',
                          ),
                          Text(
                            'age: ${booking.age}',
                          ),
                          Text(
                            'noc: ${booking.noc}',
                          ),
                          Text(
                            'noa: ${booking.noa}',
                          ),

                          TextButton(
                            onPressed: () {
                              if (booking.id != null) {
                                context.read<UserBloc>().add(
                                    DeleteUserBookingEvent(
                                        booking.id!, booking.hotelId!));
                                // context.read<UserBloc>().add(
                                //       DeleteHotelBookingEvent(
                                //         hotelId: booking.id!,
                                //         bookingId: booking.bookId!,
                                //       ),
                                //     );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Booking ID is null, cannot delete.")),
                                );
                              }
                            },
                            child: const Text('Cancel Booking'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                // return buildBookingCard(bookings[index]);
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

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTimeRange?) onDateRangeSelected;

  const DateRangePickerWidget({
    super.key,
    required this.onDateRangeSelected,
  });

  @override
  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange? selectedDateRange;

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now(),
          ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDateRange != null) {
      setState(() {
        selectedDateRange = pickedDateRange;
      });

      widget.onDateRangeSelected(pickedDateRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          selectedDateRange == null
              ? "No date range selected"
              : "Selected: ${selectedDateRange!.start.toLocal()} - ${selectedDateRange!.end.toLocal()}",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => selectDateRange(context),
          child: const Text("Select Date Range"),
        ),
      ],
    );
  }
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