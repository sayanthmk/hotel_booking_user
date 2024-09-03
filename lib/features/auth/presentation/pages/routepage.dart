import 'package:flutter/material.dart';
import 'package:hotel_booking/features/auth/presentation/pages/email_login.dart';
import 'package:hotel_booking/features/auth/presentation/pages/google_login.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/cusombutton.dart';

class AuthSelectionPage extends StatelessWidget {
  const AuthSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Login With Email",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmailPasswordLoginPage()),
                );
              },
              color: Colors.blue,
              textColor: Colors.white,
              borderRadius: 10.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: 300,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Login With Google",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GoogleLoginPage()),
                );
              },
              color: Colors.blue,
              textColor: Colors.white,
              borderRadius: 10.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
