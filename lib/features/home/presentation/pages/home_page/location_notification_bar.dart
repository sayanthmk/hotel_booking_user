import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/utils/alertbox.dart';

class LocationWithNotificationBar extends StatelessWidget {
  const LocationWithNotificationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFFF5F9FF)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text(
                        'Current Location',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.locationDot,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Shiradi, Maharashtra',
                        style: TextStyle(
                            color: HotelBookingColors.basictextcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  FontAwesomeIcons.bell,
                  color: Color(0xFF1E91B6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
