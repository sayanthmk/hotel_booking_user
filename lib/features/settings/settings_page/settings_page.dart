import 'package:flutter/material.dart';
import 'package:hotel_booking/features/settings/about_us.dart';
import 'package:hotel_booking/features/settings/privacy_policy.dart';
import 'package:hotel_booking/features/settings/settings_page/settings_item.dart';
import 'package:hotel_booking/features/settings/terms_conditions.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookingAppbar(heading: 'Settings'),
      backgroundColor: Colors.grey[50],
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsSection(
            context,
            title: 'App Preferences',
            children: [
              SettingsItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'Choose your preferred language',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.share,
                title: 'Share',
                subtitle: 'Share the app with friends',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSettingsSection(
            context,
            title: 'Legal & About',
            children: [
              SettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy(),
                  ));
                },
              ),
              SettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms and Conditions',
                subtitle: 'View terms of service',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TermsConditions(),
                  ));
                },
              ),
              SettingsItem(
                icon: Icons.info_outline,
                title: 'About Us',
                subtitle: 'Learn more about our company',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children.asMap().entries.map((entry) {
              final index = entry.key;
              final child = entry.value;
              return Column(
                children: [
                  child,
                  if (index != children.length - 1)
                    Divider(
                      height: 1,
                      indent: 56,
                      endIndent: 16,
                      color: Colors.grey[200],
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
