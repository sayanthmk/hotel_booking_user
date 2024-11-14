import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/widgets/custom_circle.dart';

class HotelImageBox extends StatelessWidget {
  const HotelImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
      builder: (context, state) {
        if (state is SelectedHotelLoaded) {
          final hotel = state.hotel;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                // Main hotel image as background
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          hotel.images[0]), // 0th index image from database
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),

                // Positioned container for "Interior/Exterior" labels
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Interior',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        Text(
                          'Exterior',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),

                // Positioned buttons: Favorite, Share, Close
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      CustomCircleAvatar(
                        iconColor: Colors.red,
                        onTap: () {},
                        icon: Icons.favorite,
                      ),
                      const SizedBox(width: 10),
                      CustomCircleAvatar(
                        iconColor: Colors.black,
                        onTap: () {},
                        icon: Icons.share,
                      ),
                      const SizedBox(width: 10),
                      CustomCircleAvatar(
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icons.close,
                      ),
                    ],
                  ),
                ),

                // Bottom-left text (Hotel name and rating)
                Positioned(
                  bottom: 20,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 200,
                        child: Text(
                          hotel.hotelName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            SizedBox(width: 5),
                            Text(
                              '4.5/5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom-right container showing additional images
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Column(
                    children: [
                      Row(
                        children: hotel.images.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String imageUrl = entry.value;

                          // Skip the 0th image as it's already the main background
                          if (idx == 0) return const SizedBox.shrink();

                          return Container(
                            height: 45,
                            width: 45,
                            margin: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 2, color: Colors.white),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '₹${hotel.panNumber}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Error loading hotel details.'));
        }
      },
    );
  }
}
