import 'package:flutter/material.dart';
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
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms and Conditions',
                subtitle: 'View terms of service',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.info_outline,
                title: 'About Us',
                subtitle: 'Learn more about our company',
                onTap: () {},
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

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color baseColor =
        isDestructive ? Colors.red : Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 22,
                color: baseColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDestructive ? Colors.red : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
