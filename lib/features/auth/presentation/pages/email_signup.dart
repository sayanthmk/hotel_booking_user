import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/cusombutton.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/divider.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/textfrom_field.dart';
import 'package:hotel_booking/features/home/presentation/pages/home.dart';
import 'package:hotel_booking/utils/texts/text.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Sign Up'),
      // ),
      body: BlocListener<AuthBloc, Authstate>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Create Account',
                fontSize: 25.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Create an account so you can explore the hotels',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                controller: emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
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
                prefixIcon: const Icon(Icons.lock),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
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
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: confirmpasswordController,
                labelText: 'Confirm Password',
                hintText: 'Enter your Password',
                prefixIcon: const Icon(Icons.lock),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
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
                text: "Login",
                onTap: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  context.read<AuthBloc>().add(
                        SignUpEmailPasswordEvent(
                          email: email,
                          password: password,
                        ),
                      );
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
              ),
              const SizedBox(
                height: 20,
              ),
              const DividerWithText(
                text: 'or',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: Colors.blue,
                dividerColor: Colors.blue,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  text: "",
                  onTap: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  borderRadius: 10.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  height: 60,
                  width: 300,
                  icon: FontAwesomeIcons.google),
            ],
          ),
        ),
      ),
    );
  }
}
// ElevatedButton(
//   onPressed: () {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//     context.read<AuthBloc>().add(
//           SignUpEmailPasswordEvent(
//             email: email,
//             password: password,
//           ),
//         );
//   },
//   child: const Text('Sign Up'),
// ),

// TextField(
//   controller: passwordController,
//   decoration: const InputDecoration(labelText: 'Password'),
//   obscureText: true,
// ),
    // final email = emailController.text.trim();
                    // final password = passwordController.text.trim();
                    // context.read<AuthBloc>().add(
                    //       SignUpEmailPasswordEvent(
                    //         email: email,
                    //         password: password,
                    //       ),
                    //     );
                            // const Text(
              //   'Create Account',
              //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              // ),