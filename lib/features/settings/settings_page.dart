import 'package:flutter/material.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookingAppbar(heading: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          SettingsItem(
            icon: Icons.language,
            title: 'Language',
            onTap: () {},
          ),
          SettingsItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          SettingsItem(
            icon: Icons.description_outlined,
            title: 'Terms and Conditions',
            onTap: () {},
          ),
          SettingsItem(
            icon: Icons.info_outline,
            title: 'About Us',
            onTap: () {
              // TODO: Navigate to about us page
            },
          ),
          SettingsItem(
            icon: Icons.share,
            title: 'Share',
            onTap: () {
              // TODO: Implement share functionality
            },
          ),
          SettingsItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              // TODO: Implement share functionality
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : Theme.of(context).iconTheme.color,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : null,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
