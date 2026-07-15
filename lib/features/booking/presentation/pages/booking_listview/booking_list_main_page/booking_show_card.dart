import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/booking_detail_page.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_list_main_page/widgets/cancel_booking_sec.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:intl/intl.dart';

enum _BookingStatus { upcoming, ongoing, completed }

class BookingShowCard extends StatelessWidget {
  const BookingShowCard({
    super.key,
    required this.booking,
  });

  final UserDataModel booking;

  _BookingStatus get _status {
    final now = DateTime.now();
    if (now.isBefore(booking.startdate!)) return _BookingStatus.upcoming;
    if (now.isAfter(booking.enddate!)) return _BookingStatus.completed;
    return _BookingStatus.ongoing;
  }

  Color _statusColor() {
    switch (_status) {
      case _BookingStatus.upcoming:
        return AppColors.primary;
      case _BookingStatus.ongoing:
        return Colors.green.shade600;
      case _BookingStatus.completed:
        return AppColors.textGrey;
    }
  }

  String _statusLabel() {
    switch (_status) {
      case _BookingStatus.upcoming:
        return 'Upcoming';
      case _BookingStatus.ongoing:
        return 'Ongoing';
      case _BookingStatus.completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final startdate = DateFormat('dd MMM yyyy').format(booking.startdate!);
    final enddate = DateFormat('dd MMM yyyy').format(booking.enddate!);
    final nights = booking.enddate!.difference(booking.startdate!).inDays;
    final statusColor = _statusColor();
    final shortId = 'ID: ${booking.bookId ?? ''}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: statusColor.withOpacity(0.1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _statusLabel(),
                      style: AppTextStyles.rating.copyWith(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      (shortId.length > 14
                              ? shortId.substring(0, 14)
                              : shortId)
                          .toUpperCase(),
                      style: AppTextStyles.hotelLocation.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.name ?? 'Hotel',
                      style: AppTextStyles.hotelName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,
                            size: 15, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            booking.place ?? '',
                            style: AppTextStyles.hotelLocation,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child:
                              _DateBlock(label: 'Check-in', date: startdate),
                        ),
                        Column(
                          children: [
                            Container(
                                height: 28,
                                width: 1,
                                color: AppColors.background),
                            const SizedBox(height: 4),
                            Text(
                              '$nights night${nights == 1 ? '' : 's'}',
                              style: AppTextStyles.hotelLocation
                                  .copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                        Expanded(
                          child: _DateBlock(
                            label: 'Check-out',
                            date: enddate,
                            alignEnd: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.person_outline,
                            size: 16, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Text(
                          '${booking.noa ?? 0} Adults',
                          style: AppTextStyles.hotelLocation,
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.child_care,
                            size: 16, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Text(
                          '${booking.noc ?? 0} Children',
                          style: AppTextStyles.hotelLocation,
                        ),
                        const Spacer(),
                        if (booking.paidAmount != null)
                          Text(
                            '₹${booking.paidAmount!.toStringAsFixed(0)}',
                            style: AppTextStyles.price,
                          ),
                      ],
                    ),
                    if (_status != _BookingStatus.completed) ...[
                      const SizedBox(height: 16),
                      CancelBookingSection(booking: booking),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({
    required this.label,
    required this.date,
    this.alignEnd = false,
  });

  final String label;
  final String date;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.hotelLocation),
        const SizedBox(height: 4),
        Text(date,
            style: AppTextStyles.hotelName.copyWith(fontSize: 14)),
      ],
    );
  }
}
