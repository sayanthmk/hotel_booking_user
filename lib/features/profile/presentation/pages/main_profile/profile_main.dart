import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/pages/main_profile/menu_item.dart';
import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/profile_page/profile_page.dart';
import 'package:hotel_booking/features/settings/contact_us.dart';
import 'package:hotel_booking/features/settings/settings_page/settings_page.dart';
import 'package:hotel_booking/utils/alertbox/alertbox.dart';
import '../../../../auth/presentation/pages/routepage.dart';

class ProfileUiNew extends StatelessWidget {
  const ProfileUiNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: HotelBookingColors.basictextcolor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: HotelBookingColors.basictextcolor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "Information",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    MenuItemWidget(
                      icon: Icons.person,
                      title: "Profile",
                      subtitle: "View and edit your profile details",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PrpageMyProfilePage(),
                        ));
                      },
                    ),
                    MenuItemWidget(
                      icon: Icons.settings,
                      title: "Settings",
                      subtitle: "App preferences and configuration",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
                      },
                    ),
                    MenuItemWidget(
                      icon: Icons.contact_support_sharp,
                      title: "Contact Us",
                      subtitle: "Get help and support",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ContactUsPage(),
                        ));
                      },
                    ),
                    MenuItemWidget(
                      icon: Icons.question_answer,
                      title: "FAQs",
                      subtitle: "Frequently asked questions",
                      onTap: () {},
                    ),
                    MenuItemWidget(
                      icon: Icons.logout_rounded,
                      title: "Logout",
                      subtitle: "Sign out of your account",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            titleText: 'Logout',
                            contentText: 'Are you sure you want to Logout?',
                            buttonText1: 'Cancel',
                            buttonText2: 'Logout',
                            onPressButton1: () {
                              Navigator.of(context).pop();
                            },
                            onPressButton2: () async {
                              context.read<AuthBloc>().add(SignOutEvent());
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthSelectionPage(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        );
                      },
                      isLastItem: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
