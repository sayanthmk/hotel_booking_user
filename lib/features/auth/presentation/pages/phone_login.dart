import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/utils/snackbar.dart';
import 'package:hotel_booking/features/auth/presentation/pages/email_signup.dart';
import 'package:hotel_booking/features/auth/presentation/pages/otp_verification.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/bottom_text_row.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/divider.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/gradiant_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberAuthPage extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final String countryCode = '+91';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PhoneNumberAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, Authstate>(
        listener: (context, state) {
          if (state is AuthCodeSent) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpVerificationPage(
                  verificationId: state.verificationId,
                ),
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
                      IntlPhoneField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          // print(phone.completeNumber);
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                          text: "Send OTP",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final phoneNumber =
                                  // '$countryCode${_phoneController.text}';
                                  _phoneController.text;
                              context.read<AuthBloc>().add(
                                    SignInPhoneNumberEvent(
                                        phoneNumber: phoneNumber),
                                  );
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
                      const SizedBox(
                        height: 20,
                      ),
                      const DividerWithText(
                        text: 'or',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.grey,
                        dividerColor: Colors.grey,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: "",
                        onTap: () {
                          context.read<AuthBloc>().add(SignInGoogleEvent());
                        },
                        color: Colors.white,
                        textColor: Colors.grey,
                        borderRadius: 10.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        height: 60,
                        width: 350,
                        icon: FontAwesomeIcons.google,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SignInRow(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        signInText: 'Sign Up',
                        promptText: 'Create a account? ',
                        signInTextColor: Colors.blue,
                      ),
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
