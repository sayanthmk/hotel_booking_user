import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/home/presentation/widgets/section_header.dart';
import 'package:hotel_booking/features/home/presentation/widgets/vertical_hotel_details.dart';
import 'package:hotel_booking/utils/alertbox.dart';

class RoomBookingHome extends StatelessWidget {
  const RoomBookingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 70,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Location'),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                size: 18,
                              ),
                              Text('Shiradi, Maharashtra'),
                            ],
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
                                      builder: (context) =>
                                          const AuthSelectionPage(),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(FontAwesomeIcons.rightFromBracket),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 250,
                    decoration: const BoxDecoration(color: Colors.green),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SectionHeader(
                title: 'Hotel Near You',
                actionText: 'View All',
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const HotelCard(
                      image: 'assets/images/hotel_image.jpg',
                      hotelName: 'Raddison Hotel',
                      location: 'Thane, Mumbai',
                      price: 3422,
                      oldPrice: 4000,
                      rating: 4.5,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 