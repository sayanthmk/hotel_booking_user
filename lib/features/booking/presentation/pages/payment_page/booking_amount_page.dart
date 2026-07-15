// booking_amount_page.dart
//
// Confirms payment for a booked room. Computes the total amount from the
// room's price per night and the selected stay dates (no manual amount
// entry), then hands the computed amount to StripeBloc to collect payment.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_sucess_screen/booking_success_screen.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_bloc.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_event.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_state.dart';
import 'package:hotel_booking/utils/snackbar/snackbar.dart';

class BookingAmountPage extends StatelessWidget {
  final UserDataModel bookingData;
  final String hotelId;
  final RoomEntity room;

  const BookingAmountPage({
    required this.bookingData,
    required this.hotelId,
    required this.room,
    super.key,
  });

  int get _nights {
    final start = bookingData.startdate;
    final end = bookingData.enddate;
    if (start == null || end == null) return 1;
    final diff = end.difference(start).inDays;
    return diff <= 0 ? 1 : diff;
  }

  int get _totalAmount => _nights * room.basePrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<StripeBloc, StripePaymentState>(
          listener: (context, state) {
            if (state is StripePaymentSuccess) {
              final updatedBookingData = UserDataModel(
                name: bookingData.name,
                age: bookingData.age,
                place: bookingData.place,
                startdate: bookingData.startdate,
                enddate: bookingData.enddate,
                noc: bookingData.noc,
                noa: bookingData.noa,
                roomId: bookingData.roomId,
                paidAmount: _totalAmount.toDouble(),
                bookingDate: bookingData.bookingDate,
              );
              context
                  .read<UserBloc>()
                  .add(SaveUserDataEvent(updatedBookingData, hotelId));
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const BookingSuccessPage(),
              ));
              showCustomSnackBar(
                  context, 'Payment Successful!', Colors.green);
            }
            if (state is StripePaymentFailure) {
              showCustomSnackBar(
                  context, 'Payment Failed: ${state.error}', Colors.red);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildTopBar(context),
                Expanded(
                  child: state is StripePaymentLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primary),
                        )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Room', style: AppTextStyles.sectionTitle),
                              const SizedBox(height: 12),
                              _RoomSummaryCard(room: room),
                              const SizedBox(height: 24),
                              Text('Price breakdown',
                                  style: AppTextStyles.sectionTitle),
                              const SizedBox(height: 12),
                              _AmountBreakdownCard(
                                nights: _nights,
                                pricePerNight: room.basePrice,
                                total: _totalAmount,
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<StripeBloc>().add(
                                        InitiatePayment(
                                            _totalAmount.toDouble()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'Pay ₹$_totalAmount',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: AppColors.textDark, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          const Text('Confirm Payment', style: AppTextStyles.username),
        ],
      ),
    );
  }
}

class _RoomSummaryCard extends StatelessWidget {
  final RoomEntity room;
  const _RoomSummaryCard({required this.room});

  @override
  Widget build(BuildContext context) {
    final imageUrl = room.images.isNotEmpty ? room.images.first : null;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 64,
              height: 64,
              child: imageUrl == null
                  ? Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child:
                          const Icon(Icons.bed_rounded, color: Colors.white),
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primaryDark
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(Icons.bed_rounded,
                            color: Colors.white),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room.roomType,
                    style: AppTextStyles.hotelName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text('₹${room.basePrice} /night',
                    style: AppTextStyles.priceUnit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountBreakdownCard extends StatelessWidget {
  final int nights;
  final int pricePerNight;
  final int total;

  const _AmountBreakdownCard({
    required this.nights,
    required this.pricePerNight,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _AmountRow(
            label: '₹$pricePerNight x $nights night${nights > 1 ? 's' : ''}',
            value: '₹$total',
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.background),
          const SizedBox(height: 10),
          _AmountRow(label: 'Total amount', value: '₹$total', isTotal: true),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  const _AmountRow(
      {required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.sectionTitle.copyWith(fontSize: 15)
              : AppTextStyles.hotelLocation,
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.price.copyWith(fontSize: 17)
              : AppTextStyles.chip.copyWith(color: AppColors.textDark),
        ),
      ],
    );
  }
}
