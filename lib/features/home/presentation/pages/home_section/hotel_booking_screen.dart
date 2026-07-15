// hotel_booking_screen.dart
//
// Booking screen reached from a room's detail page via "Book Now".
// Reads the selected hotel (SelectedHotelBloc) and selected room
// (SelectedRoomBloc), collects guest details, and hands off to the
// existing PaymentPage / UserBloc save flow.
// Reuses AppColors / AppTextStyles from home_page_section.dart so it
// stays visually consistent with the rest of the home experience.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/payment_page/booking_amount_page.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';
import 'package:hotel_booking/utils/snackbar/snackbar.dart';

class HotelBookingScreen extends StatelessWidget {
  const HotelBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
          builder: (context, hotelState) {
            if (hotelState is! SelectedHotelLoaded) {
              return const Center(
                child: Text('No hotel selected',
                    style: AppTextStyles.hotelLocation),
              );
            }
            return BlocBuilder<SelectedRoomBloc, SelectedRoomState>(
              builder: (context, roomState) {
                if (roomState is! RoomSelected) {
                  return const Center(
                    child: Text('No room selected',
                        style: AppTextStyles.hotelLocation),
                  );
                }
                return _BookingForm(
                  hotel: hotelState.hotel,
                  room: roomState.selectedRoom,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _BookingForm extends StatefulWidget {
  final HotelEntity hotel;
  final RoomEntity room;
  const _BookingForm({required this.hotel, required this.room});

  @override
  State<_BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<_BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();

  int _adults = 1;
  int _children = 0;
  DateTime? _checkIn;
  DateTime? _checkOut;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  int get _nights =>
      _checkIn != null && _checkOut != null
          ? _checkOut!.difference(_checkIn!).inDays
          : 0;

  int get _totalPrice => (_nights == 0 ? 1 : _nights) * widget.room.basePrice;

  Future<void> _pickDates() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      initialDateRange: _checkIn != null && _checkOut != null
          ? DateTimeRange(start: _checkIn!, end: _checkOut!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (range != null) {
      setState(() {
        _checkIn = range.start;
        _checkOut = range.end;
      });
    }
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    if (_checkIn == null || _checkOut == null) {
      showCustomSnackBar(
          context, 'Please select check-in and check-out dates', Colors.red);
      return;
    }

    final bookingData = UserDataModel(
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      place: _placeController.text.trim(),
      startdate: _checkIn,
      enddate: _checkOut,
      noc: _children,
      noa: _adults,
      roomId: widget.room.roomId,
      bookingDate: DateTime.now(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingAmountPage(
          bookingData: bookingData,
          hotelId: widget.hotel.hotelId,
          room: widget.room,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          showCustomSnackBar(context, state.message, Colors.red);
        } else if (state is UserDataSavedState) {
          showCustomSnackBar(context, 'Booking saved successfully', Colors.green);
        }
      },
      builder: (context, userState) {
        return Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HotelSummaryCard(hotel: widget.hotel, room: widget.room),
                      const SizedBox(height: 24),
                      const Text('Your details', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 12),
                      _DetailsCard(
                        nameController: _nameController,
                        ageController: _ageController,
                        placeController: _placeController,
                      ),
                      const SizedBox(height: 24),
                      const Text('Guests', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 12),
                      _GuestsCard(
                        adults: _adults,
                        children: _children,
                        onAdultsChanged: (v) => setState(() => _adults = v),
                        onChildrenChanged: (v) => setState(() => _children = v),
                      ),
                      const SizedBox(height: 24),
                      const Text('Select dates', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 12),
                      _DatesCard(
                        checkIn: _checkIn,
                        checkOut: _checkOut,
                        onTap: _pickDates,
                      ),
                      const SizedBox(height: 24),
                      _PriceSummaryCard(
                        nights: _nights,
                        pricePerNight: widget.room.basePrice,
                        total: _totalPrice,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomBar(context, userState),
          ],
        );
      },
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
          const Text('Confirm & book', style: AppTextStyles.username),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, UserState userState) {
    final isSaving = userState is UserLoadingState;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('₹$_totalPrice', style: AppTextStyles.price.copyWith(fontSize: 20)),
                  Text(
                    _nights > 0 ? 'for $_nights night${_nights > 1 ? 's' : ''}' : 'total',
                    style: AppTextStyles.priceUnit,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: isSaving ? null : () => _submit(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.4,
                        ),
                      )
                    : const Text(
                        'Continue to payment',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HotelSummaryCard extends StatelessWidget {
  final HotelEntity hotel;
  final RoomEntity room;
  const _HotelSummaryCard({required this.hotel, required this.room});

  @override
  Widget build(BuildContext context) {
    final imageUrl = room.images.isNotEmpty
        ? room.images.first
        : (hotel.images.isNotEmpty ? hotel.images.first : null);
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
              width: 74,
              height: 74,
              child: imageUrl == null
                  ? Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(Icons.hotel_rounded,
                          color: Colors.white, size: 28),
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryDark],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(Icons.hotel_rounded,
                            color: Colors.white, size: 28),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hotel.hotelName,
                    style: AppTextStyles.hotelName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text('${hotel.city}, ${hotel.state}',
                    style: AppTextStyles.hotelLocation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    room.roomType,
                    style: AppTextStyles.chip.copyWith(
                      color: AppColors.primary,
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController placeController;
  const _DetailsCard({
    required this.nameController,
    required this.ageController,
    required this.placeController,
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
          _BookingTextField(
            controller: nameController,
            label: 'Full name',
            icon: Icons.person_outline_rounded,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
          ),
          const SizedBox(height: 14),
          _BookingTextField(
            controller: ageController,
            label: 'Age',
            icon: Icons.cake_outlined,
            keyboardType: TextInputType.number,
            validator: (v) {
              final n = int.tryParse(v?.trim() ?? '');
              if (n == null || n <= 0) return 'Enter a valid age';
              return null;
            },
          ),
          const SizedBox(height: 14),
          _BookingTextField(
            controller: placeController,
            label: 'Place',
            icon: Icons.location_on_outlined,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter your place' : null,
          ),
        ],
      ),
    );
  }
}

class _BookingTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _BookingTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyles.hotelLocation
          .copyWith(color: AppColors.textDark, fontSize: 14.5),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.hotelLocation,
        prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20),
        filled: true,
        fillColor: AppColors.background,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _GuestsCard extends StatelessWidget {
  final int adults;
  final int children;
  final ValueChanged<int> onAdultsChanged;
  final ValueChanged<int> onChildrenChanged;

  const _GuestsCard({
    required this.adults,
    required this.children,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
          _GuestCounterRow(
            label: 'Adults',
            value: adults,
            minValue: 1,
            onChanged: onAdultsChanged,
          ),
          const Divider(height: 1, color: AppColors.background),
          _GuestCounterRow(
            label: 'Children',
            value: children,
            minValue: 0,
            onChanged: onChildrenChanged,
          ),
        ],
      ),
    );
  }
}

class _GuestCounterRow extends StatelessWidget {
  final String label;
  final int value;
  final int minValue;
  final ValueChanged<int> onChanged;

  const _GuestCounterRow({
    required this.label,
    required this.value,
    required this.minValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyles.chip.copyWith(color: AppColors.textDark)),
          Row(
            children: [
              _CounterButton(
                icon: Icons.remove_rounded,
                onTap: value > minValue ? () => onChanged(value - 1) : null,
              ),
              SizedBox(
                width: 32,
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                ),
              ),
              _CounterButton(
                icon: Icons.add_rounded,
                onTap: () => onChanged(value + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? AppColors.primary : AppColors.textGrey,
        ),
      ),
    );
  }
}

class _DatesCard extends StatelessWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;
  final VoidCallback onTap;

  const _DatesCard({
    required this.checkIn,
    required this.checkOut,
    required this.onTap,
  });

  String _format(DateTime? date) =>
      date == null ? 'Select date' : DateFormat('dd MMM yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Row(
          children: [
            Expanded(
              child: _DateTile(label: 'Check-in', value: _format(checkIn)),
            ),
            Container(
              width: 1,
              height: 36,
              color: AppColors.background,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Expanded(
              child: _DateTile(label: 'Check-out', value: _format(checkOut)),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.calendar_month_rounded,
                  color: AppColors.primary, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final String value;
  const _DateTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.hotelLocation),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.chip.copyWith(color: AppColors.textDark),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _PriceSummaryCard extends StatelessWidget {
  final int nights;
  final int pricePerNight;
  final int total;

  const _PriceSummaryCard({
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
          _PriceRow(
            label: nights > 0
                ? '₹$pricePerNight x $nights night${nights > 1 ? 's' : ''}'
                : '₹$pricePerNight x 1 night',
            value: '₹$total',
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.background),
          const SizedBox(height: 10),
          _PriceRow(
            label: 'Total',
            value: '₹$total',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  const _PriceRow(
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
