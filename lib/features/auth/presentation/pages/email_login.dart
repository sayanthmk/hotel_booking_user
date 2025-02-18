import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/validator/validators.dart';
import 'package:hotel_booking/utils/bottom_navbar/bottom_navbar.dart';
import 'package:hotel_booking/utils/snackbar/snackbar.dart';
import 'package:hotel_booking/features/auth/presentation/pages/email_signup.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/bottom_text_row.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/divider.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/gradiant_button.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/textfrom_field.dart';

class EmailPasswordLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EmailPasswordLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: HotelBookingColors.white,
        body: BlocListener<AuthBloc, Authstate>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BtBar(),
                ),
              );
            } else if (state is AuthError) {
              showCustomSnackBar(context, 'Invalid mail/Password', Colors.red);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: emailController,
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        borderColor: Colors.grey,
                        focusedBorderColor: Colors.blue,
                        enabledBorderColor: Colors.grey,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: CustomValidator.validatePassword,
                        borderColor: Colors.grey,
                        focusedBorderColor: Colors.blue,
                        enabledBorderColor: Colors.grey,
                        errorBorderColor: Colors.red,
                        obscureText: true,
                        suffixIcon: const Icon(Icons.remove_red_eye),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: "Login",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            context.read<AuthBloc>().add(
                                  SignInEmailPasswordEvent(
                                    email: email,
                                    password: password,
                                  ),
                                );
                          }
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        borderRadius: 10.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        height: 50,
                        width: 300,
                        gradient: HotelBookingColors.primarybuttongradient,
                      ),
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
          ),
        ),
      ),
    );
  }
}
