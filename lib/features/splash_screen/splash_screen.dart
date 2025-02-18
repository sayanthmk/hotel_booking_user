import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/features/onboarding/onboarding_page.dart';
import 'package:hotel_booking/utils/bottom_navbar/bottom_navbar.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStatusPage extends StatelessWidget {
  const LoginStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: AnimatedSplashScreen(
                splash: Column(
                  children: [
                    Center(
                      child: LottieBuilder.asset(
                          'assets/lottie/loading_animation.json'),
                    )
                  ],
                ),
                duration: 5000,
                nextScreen:
                    snapshot.data == true ? const BtBar() : const Onbording(),
                splashIconSize: 400,
                backgroundColor: Colors.white,
              ),
            ),
          );
        } else if (snapshot.data == true) {
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
