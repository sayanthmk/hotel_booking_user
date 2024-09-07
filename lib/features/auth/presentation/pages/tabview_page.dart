import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/auth/presentation/pages/email_login.dart';
import 'package:hotel_booking/features/auth/presentation/pages/phone_login.dart';

class TabBarViewPage extends StatelessWidget {
  const TabBarViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Login here",
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: HotelBookingColors.headingblue),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome back you've \nbeen missed!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Email'),
                Tab(text: 'Phone Number'),
              ],
              dividerColor: Colors.transparent,
              indicatorColor: HotelBookingColors.headingblue,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  EmailPasswordLoginPage(),
                  PhoneNumberAuthPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
