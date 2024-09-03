import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home.dart';

class GoogleLoginPage extends StatelessWidget {
  const GoogleLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Login'),
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
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignInGoogleEvent());
            },
            child: const Text('Sign in with Google'),
          ),
        ),
      ),
    );
  }
}
