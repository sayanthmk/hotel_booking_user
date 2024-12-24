import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/widgets/hoteldetail_info.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';

class HotelBookingDetailPage extends StatelessWidget {
  final String hotelId;

  const HotelBookingDetailPage({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    context.read<HotelBloc>().add(LoadHotelByIdEvent(hotelId));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Contact Hotel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: HotelBookingColors.basictextcolor,
              ),
            );
          }

          if (state is HotelErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error Loading Hotel Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is HotelDetailLoadedState) {
            final hotel = state.hotel;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: hotel.images.isNotEmpty
                          ? Image.network(
                              hotel.images[0],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.red[300],
                                      size: 48,
                                    ),
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: HotelBookingColors.basictextcolor,
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey[400],
                                  size: 48,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        HotelContactInfoRow(
                            icon: Icons.phone,
                            label: 'Contact Number',
                            value: hotel.contactNumber),
                        const SizedBox(height: 12),
                        HotelContactInfoRow(
                            icon: Icons.email,
                            label: 'Email Address',
                            value: hotel.emailAddress),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        HotelContactInfoRow(
                            icon: Icons.location_city,
                            label: 'City',
                            value: hotel.city),
                        const SizedBox(height: 12),
                        HotelContactInfoRow(
                            icon: Icons.map,
                            label: 'State',
                            value: hotel.state),
                        const SizedBox(height: 12),
                        HotelContactInfoRow(
                            icon: Icons.public,
                            label: 'Country',
                            value: hotel.country),
                        const SizedBox(height: 12),
                        HotelContactInfoRow(
                            icon: Icons.pin_drop,
                            label: 'Pincode',
                            value: hotel.pincode.toString()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }

          return const Center(
            child: Text('No hotel details available'),
          );
        },
      ),
    );
  }
}
