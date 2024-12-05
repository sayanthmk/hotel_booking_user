import 'package:flutter/material.dart';
import 'package:hotel_booking/features/onboarding/onboarding_page.dart';
import 'package:hotel_booking/utils/bottom_navbar/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStatusPage extends StatelessWidget {
  const LoginStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data == true) {
          // return const RoomBookingHome();
          return const BtBar();
        } else {
          return const Onbording();
        }
      },
    );
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
