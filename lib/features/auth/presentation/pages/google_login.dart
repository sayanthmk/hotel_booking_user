import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/booking_home.dart';
import 'package:hotel_booking/utils/snackbar/snackbar.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';

class GoogleLoginPage extends StatelessWidget {
  const GoogleLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, Authstate>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RoomBookingHome(),
              ),
            );
          } else if (state is AuthError) {
            showCustomSnackBar(
                context, 'Unauthorised authentication', Colors.red);
          }
        },
      ),
    );
  }
}
