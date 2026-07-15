import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/widgets/hoteldetail_info.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';

class HotelBookingDetailPage extends StatelessWidget {
  final String hotelId;

  const HotelBookingDetailPage({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    context.read<HotelBloc>().add(LoadHotelByIdEvent(hotelId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text('Contact Hotel', style: AppTextStyles.sectionTitle),
      ),
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is HotelErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded,
                      size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  const Text(
                    'Error Loading Hotel Details',
                    style: AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: AppTextStyles.hotelLocation,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is HotelDetailLoadedState) {
            final hotel = state.hotel;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: SizedBox(
                      width: double.infinity,
                      height: 220,
                      child: hotel.images.isNotEmpty
                          ? Image.network(
                              hotel.images[0],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _imagePlaceholder();
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: AppColors.primary.withOpacity(0.08),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                );
                              },
                            )
                          : _imagePlaceholder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Contact Information',
                    children: [
                      HotelContactInfoRow(
                        icon: Icons.phone_rounded,
                        label: 'Contact Number',
                        value: hotel.contactNumber,
                      ),
                      const SizedBox(height: 16),
                      HotelContactInfoRow(
                        icon: Icons.email_rounded,
                        label: 'Email Address',
                        value: hotel.emailAddress,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSectionCard(
                    title: 'Location Details',
                    children: [
                      HotelContactInfoRow(
                        icon: Icons.location_city_rounded,
                        label: 'City',
                        value: hotel.city,
                      ),
                      const SizedBox(height: 16),
                      HotelContactInfoRow(
                        icon: Icons.map_rounded,
                        label: 'State',
                        value: hotel.state,
                      ),
                      const SizedBox(height: 16),
                      HotelContactInfoRow(
                        icon: Icons.public_rounded,
                        label: 'Country',
                        value: hotel.country,
                      ),
                      const SizedBox(height: 16),
                      HotelContactInfoRow(
                        icon: Icons.pin_drop_rounded,
                        label: 'Pincode',
                        value: hotel.pincode.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text('No hotel details available',
                style: AppTextStyles.hotelLocation),
          );
        },
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(Icons.hotel_rounded, size: 48, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }
}
