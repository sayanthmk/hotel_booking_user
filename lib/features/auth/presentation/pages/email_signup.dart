import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/validator/validators.dart';
import 'package:hotel_booking/utils/snackbar/snackbar.dart';
import 'package:hotel_booking/features/auth/presentation/pages/tabview_page.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/bottom_text_row.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/divider.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/gradiant_button.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/textfrom_field.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpPage({super.key});

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
                  builder: (context) => const TabBarViewPage(),
                ),
              );
            } else if (state is AuthError) {
              showCustomSnackBar(
                  context, 'Unauthorised authentication', Colors.red);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Create account",
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 31, 19, 249)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Create an account so you can explore the hotels',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: CustomValidator.validateEmail,
                        borderColor: Colors.grey,
                        focusedBorderColor: Colors.blue,
                        enabledBorderColor: Colors.grey,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
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
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: confirmpasswordController,
                        labelText: 'Confirm Password',
                        hintText: 'Enter your Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirmation password is required';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        borderColor: Colors.grey,
                        focusedBorderColor: Colors.blue,
                        enabledBorderColor: Colors.grey,
                        errorBorderColor: Colors.red,
                        obscureText: true,
                        suffixIcon: const Icon(Icons.remove_red_eye),
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        text: "Sign Up",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            context.read<AuthBloc>().add(
                                  SignUpEmailPasswordEvent(
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
                            vertical: 15.0, horizontal: 30.0),
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
                              builder: (context) => const TabBarViewPage(),
                            ),
                          );
                        },
                        signInText: 'Sign In',
                        promptText: 'Already have an account? ',
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
