import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/booking_home.dart';
import 'package:hotel_booking/utils/snackbar.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/gradiant_button.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatelessWidget {
  final String verificationId;
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  OtpVerificationPage({super.key, required this.verificationId});

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HotelBookingColors.white,
      body: BlocConsumer<AuthBloc, Authstate>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RoomBookingHome(),
              ),
            );
          }
          if (state is AuthError) {
            showCustomSnackBar(
                context, 'Unauthorised authentication', Colors.red);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        length: 6,
                        controller: _otpController,
                        pinAnimationType: PinAnimationType.scale,
                        onCompleted: (pin) {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  VerifyOTPEvent(
                                    verificationId: verificationId,
                                    smsCode: pin,
                                  ),
                                );
                          }
                        },
                        validator: _validateOtp,
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                          text: "Verify",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final otp = _otpController.text;
                              if (otp.length == 6) {
                                context.read<AuthBloc>().add(
                                      VerifyOTPEvent(
                                        verificationId: verificationId,
                                        smsCode: otp,
                                      ),
                                    );
                              }
                            }
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          borderRadius: 10.0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 30.0),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          height: 50,
                          width: 300,
                          gradient: HotelBookingColors.primarybuttongradient),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
