import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/widgets/search_chip.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/wishlist/presentation/provider/bloc/favorites_bloc.dart';

class FavoritesCard extends StatelessWidget {
  final dynamic hotel;
  final String hotelId;

  const FavoritesCard({
    super.key,
    required this.hotel,
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          context.read<SelectedHotelBloc>().add(SelectHotelEvent(hotel));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HotelDetailPage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      hotel.images[0],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error_outline, size: 40),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        hotel.hotelType,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HotelBookingColors.basictextcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            hotel.hotelName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: HotelBookingColors.basictextcolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '₹${hotel.propertySetup}/night',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.red[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${hotel.city}, ${hotel.country}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Row(
                          children: [
                            AmentityChip(label: 'Free WiFi', icon: Icons.wifi),
                            AmentityChip(
                                label: 'Parking', icon: Icons.local_parking),
                            AmentityChip(label: 'AC', icon: Icons.ac_unit)
                          ],
                        ),
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          const Text('Remove from Favorites'),
                                      content: const Text(
                                          'Are you sure you want to remove this hotel from favorites?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context.read<FavoritesBloc>().add(
                                                RemoveFromFavoritesEvent(
                                                    hotelId));
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          child: const Text('Remove'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Icon(Icons.delete,
                                    color: Colors.red)))
                      ],
                    ),
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
