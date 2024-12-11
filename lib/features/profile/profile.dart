import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/utils/alertbox.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    titleText: 'Delete',
                    contentText: 'Are you sure you want to logout?',
                    buttonText1: 'Cancel',
                    buttonText2: 'Logout',
                    onPressButton1: () {
                      Navigator.of(context).pop();
                    },
                    onPressButton2: () {
                      Navigator.of(context).pop();
                      context.read<AuthBloc>().add(SignOutEvent());
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AuthSelectionPage(),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.logout,
                color: Color(0xFF1E91B6),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('My profile'),
      ),
    );
  }
}
