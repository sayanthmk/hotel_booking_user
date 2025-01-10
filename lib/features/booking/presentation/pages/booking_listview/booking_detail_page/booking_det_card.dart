import 'package:flutter/material.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/widgets/card_items_info_section.dart';
import 'package:intl/intl.dart';

class BookingDetailPageCard extends StatelessWidget {
  const BookingDetailPageCard({
    super.key,
    required this.booking,
  });

  final UserDataModel booking;

  @override
  Widget build(BuildContext context) {
    String startdate = DateFormat('dd MMM yyyy').format(booking.startdate!);
    String enddate = DateFormat('dd MMM yyyy').format(booking.enddate!);
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCardItemsInfoSection(
                label: 'Booking ID',
                value: booking.bookId!.substring(0, 10).toUpperCase(),
                icon: Icons.confirmation_number,
              ),
              const Divider(height: 32),
              BookCardItemsInfoSection(
                label: 'Guest Name',
                value: booking.name!,
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: BookCardItemsInfoSection(
                      label: 'Check In',
                      value: startdate,
                      icon: Icons.calendar_today,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BookCardItemsInfoSection(
                      label: 'Check Out',
                      value: enddate,
                      icon: Icons.event_available,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: BookCardItemsInfoSection(
                      label: 'Adults',
                      value: booking.noa.toString(),
                      icon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BookCardItemsInfoSection(
                      label: 'Children',
                      value: booking.noc.toString(),
                      icon: Icons.child_care,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BookCardItemsInfoSection(
                label: 'Location',
                value: booking.place!,
                icon: Icons.location_on,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
