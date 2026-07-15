import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/settings/about_us/about_us_feature_card.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            Center(
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: ClipOval(
                  child: Image.asset('assets/icons/play_store_512.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text('Staywise', style: AppTextStyles.username),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
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
                  const Text('Our Mission', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 12),
                  Text(
                    '''At Staywise, we believe booking your perfect hotel should be effortless and enjoyable. Our innovative mobile booking application allows users to easily search for and book hotels that suit their needs.''',
                    style: AppTextStyles.hotelLocation.copyWith(
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Why Choose Us', style: AppTextStyles.sectionTitle),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: const [
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
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primary.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Experience the best in convenience and comfort with Staywise!',
                style: AppTextStyles.sectionTitle.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text('About Us', style: AppTextStyles.username),
        ],
      ),
    );
  }
}
