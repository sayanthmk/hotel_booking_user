import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/pages/email_signup.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home.dart';

class EmailPasswordLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  EmailPasswordLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Login'),
      ),
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
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  context.read<AuthBloc>().add(
                        SignInEmailPasswordEvent(
                          email: email,
                          password: password,
                        ),
                      );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontFamily: 'PTSans'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(fontFamily: 'PTSans', fontSize: 24),
                ),
              ),
              InkWell(
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
