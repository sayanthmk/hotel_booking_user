import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/widgets/custom_circle.dart';

class HotelImageBox extends StatelessWidget {
  const HotelImageBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/hotel_image.jpg'),
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

          // Bottom-left text
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                  width: 200,
                  child: Text(
                    'The Taj Mahal Palace',
                    textAlign: TextAlign.left,
                    style: TextStyle(
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

          // Bottom-right rating and text
          Positioned(
            bottom: 10,
            right: 10,
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: Colors.white),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/hotel_image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '8+',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  '₹3,200',
                  style: TextStyle(
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
  }
}
