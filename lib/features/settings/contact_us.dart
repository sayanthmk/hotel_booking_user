import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  void _launchPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch phone number';
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            const Text('Get in Touch', style: AppTextStyles.username),
            const SizedBox(height: 8),
            Text(
              "We're here to help and answer any questions you might have.",
              style: AppTextStyles.hotelLocation.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 28),
            _ContactCard(
              icon: Icons.phone_rounded,
              iconColor: AppColors.primary,
              title: 'Call Us',
              subtitle: 'Available 24/7 for your support',
              value: '+91-9898757289',
              onTap: () => _launchPhoneNumber('+91-9898757289'),
            ),
            const SizedBox(height: 16),
            _ContactCard(
              icon: Icons.email_rounded,
              iconColor: AppColors.accent,
              title: 'Email Us',
              subtitle: "We'll respond as soon as possible",
              value: 'contact@staywise.com',
              onTap: () => _launchEmail('contact@staywise.com'),
            ),
            const SizedBox(height: 28),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Office Hours', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded,
                          color: AppColors.textGrey, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Monday - Friday: 9:00 AM - 6:00 PM',
                        style: AppTextStyles.hotelLocation,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          color: AppColors.textGrey, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Location: Calicut, Kerala',
                        style: AppTextStyles.hotelLocation,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
        const Text('Contact Us', style: AppTextStyles.username),
      ],
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String value;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  double _scale = 1.0;

  void _setScale(double value) => setState(() => _scale = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setScale(0.98),
      onTapUp: (_) => _setScale(1.0),
      onTapCancel: () => _setScale(1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(18),
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(widget.icon, color: widget.iconColor, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 4),
                    Text(widget.subtitle, style: AppTextStyles.hotelLocation),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: AppTextStyles.price.copyWith(
                        color: widget.iconColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: widget.iconColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
