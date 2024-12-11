import 'package:flutter/material.dart';
import 'package:hotel_booking/features/auth/presentation/pages/email_signup.dart';
import 'package:hotel_booking/features/auth/presentation/pages/tabview_page.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/gradiant_button.dart';

class AuthSelectionPage extends StatelessWidget {
  const AuthSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 300,
                child: Image.asset('assets/images/hotel.png')),
            const Center(
              child: Text(
                textAlign: TextAlign.center,
                'Navigate the World,\nBook Your Bliss',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: "Login",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TabBarViewPage()),
                );
              },
              color: const Color(0xFF36C8F6),
              textColor: Colors.white,
              borderRadius: 10.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: 300,
              // gradient: HotelBookingColors.primarybuttongradient,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              text: "Sign Up",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              color: const Color(0xFF36C8F6),
              textColor: Colors.white,
              borderRadius: 10.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: 300,
              // gradient: HotelBookingColors.primarybuttongradient,
            ),
          ],
        ),
      ),
    );
  }
}
