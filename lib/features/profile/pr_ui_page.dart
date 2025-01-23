import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/profile/profile.dart';

import '../auth/presentation/pages/routepage.dart';

class ProfileUiNew extends StatelessWidget {
  const ProfileUiNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.filled(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutEvent());
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const AuthSelectionPage()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) =>
            UserProfileBloc(sl<FetchUsers>(), sl<UpdateCurrentUser>())
              ..add(LoadUsers()),
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // _buildHeaderSection(context),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                HotelBookingColors.lighttextcolor,
                                HotelBookingColors.basictextcolor,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 60.0),
                              const CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    AssetImage('assets/images/hotel_image.jpg'),
                                backgroundColor: Colors.white,
                              ),
                              const SizedBox(height: 10.0),
                              Text(user.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              const SizedBox(height: 10.0),
                              Text(user.email,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15.0)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildStatCard(),
                        _buildInformationCard(context),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Something went wrong. Please try again later.'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildStatCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatColumn('Battles', 'text'),
            _buildStatColumn('Birthday', 'April 7th'),
            _buildStatColumn('Age', '19 yrs'),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationCard(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
          child: SizedBox(
            width: 310.0,
            height: 300.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Information",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800),
                  ),
                  Divider(color: Colors.grey[300]),
                  _buildInfoRow(
                    context,
                    icon: Icons.home,
                    label: "Guild",
                    value: "FairyTail, Magnolia",
                  ),
                  _buildInfoRow(
                    context,
                    icon: Icons.auto_awesome,
                    label: "Magic",
                    value: "Spatial & Sword Magic, Telekinesis",
                  ),
                  _buildInfoRow(
                    context,
                    icon: Icons.favorite,
                    label: "Loves",
                    value: "Eating cakes",
                  ),
                  _buildInfoRow(
                    context,
                    icon: Icons.people,
                    label: "Team",
                    value: "Team Natsu",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, size: 35, color: Colors.blueAccent[400]),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 15.0)),
              Text(value,
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 14.0)),
        const SizedBox(height: 5.0),
        Text(value, style: const TextStyle(fontSize: 15.0)),
      ],
    );
  }
}
  // Widget _buildHeaderSection(BuildContext context) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.40,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [
  //           HotelBookingColors.lighttextcolor,
  //           HotelBookingColors.basictextcolor,
  //         ],
  //       ),
  //     ),
  //     child: const Column(
  //       children: [
  //         SizedBox(height: 60.0),
  //         CircleAvatar(
  //           radius: 65.0,
  //           backgroundImage: AssetImage('assets/images/hotel_image.jpg'),
  //           backgroundColor: Colors.white,
  //         ),
  //         SizedBox(height: 10.0),
  //         Text('Erza Scarlet',
  //             style: TextStyle(color: Colors.white, fontSize: 20.0)),
  //         SizedBox(height: 10.0),
  //         Text('S Class Mage',
  //             style: TextStyle(color: Colors.white, fontSize: 15.0)),
  //       ],
  //     ),
  //   );
  // }