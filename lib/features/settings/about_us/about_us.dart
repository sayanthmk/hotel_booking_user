import 'package:flutter/material.dart';
import 'package:hotel_booking/features/settings/about_us/about_us_feature_card.dart';
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
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                ),
                // child: Icon(
                //   Icons.hotel_rounded,
                //   size: 60,
                //   color: Colors.blue.shade700,
                // ),
                child: Image.asset('assets/icons/play_store_512.png'),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Staywise',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Mission Statement
                    const Text(
                      'Our Mission',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '''At Staywise, we believe booking your perfect hotel should be effortless and enjoyable. Our innovative mobile booking application allows users to easily search for and book hotels that suit their needs.''',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Why Choose Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                AboutFeatureCard(
                  icon: Icons.favorite_outline,
                  title: 'Wishlist',
                  description: 'Save your favorite hotels for later',
                ),
                AboutFeatureCard(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  description: 'Explore convenient hotel locations',
                ),
                AboutFeatureCard(
                  icon: Icons.chat_outlined,
                  title: 'Support',
                  description: '24/7 chat assistance available',
                ),
                AboutFeatureCard(
                  icon: Icons.hotel_outlined,
                  title: 'Details',
                  description: 'Comprehensive hotel information',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Experience the best in convenience and comfort with Staywise!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
