import 'package:flutter/material.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookingAppbar(heading: 'About Us'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5.0,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '''At Staywise, we believe booking your perfect hotel should be effortless and enjoyable. Our innovative mobile booking application allows users to easily search for and book hotels that suit their needs.
With features like adding hotels to your wishlist, viewing detailed information, and exploring convenient hotel locations, we make planning your stay a breeze. 
Additionally, our dedicated hotel booking chat assistant is always available to provide guidance and support whenever you need it. Whether you're traveling for business or leisure, Staywise is here to enhance your booking experience and help you find the ideal accommodation.''',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Experience the best in convenience and comfort with Staywise!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
