import 'package:flutter/material.dart';

class SortHotelsByLocation extends StatelessWidget {
  const SortHotelsByLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Set the height to accommodate the circle and text
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/mumbai_hotel.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Mumbai',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
