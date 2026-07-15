import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/settings/about_us/about_us.dart';
import 'package:hotel_booking/features/settings/privacy_policy.dart';
import 'package:hotel_booking/features/settings/settings_page/settings_item.dart';
import 'package:hotel_booking/features/settings/terms_conditions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
            _buildSettingsSection(
              title: 'App Preferences',
              children: [
                SettingsItem(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: 'Choose your preferred language',
                  onTap: () {},
                ),
                SettingsItem(
                  icon: Icons.share_rounded,
                  title: 'Share',
                  subtitle: 'Share the app with friends',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSettingsSection(
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
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
          const Text('Settings', style: AppTextStyles.username),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(title, style: AppTextStyles.sectionTitle),
        ),
        Container(
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
                      color: AppColors.background,
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
