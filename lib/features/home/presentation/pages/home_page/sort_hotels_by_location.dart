import 'package:flutter/material.dart';

class SortHotelsByLocation extends StatelessWidget {
  const SortHotelsByLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> locations = [
      {'image': 'assets/images/mumbai_hotel.jpg', 'text': 'Mumbai'},
      {'image': 'assets/images/dehi.jpeg', 'text': 'Delhi'},
      {'image': 'assets/images/kolkata.jpg', 'text': 'Kolkata'},
      {'image': 'assets/images/chennai.jpg', 'text': 'Chennai'},
      {'image': 'assets/images/banglore.jpg', 'text': 'Bangalore'},
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        location['image']!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      location['text']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
