import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/pr.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';
import 'package:hotel_booking/features/settings/settings_page.dart';
import 'package:hotel_booking/utils/alertbox.dart';
import '../../../../auth/presentation/pages/routepage.dart';

class ProfileUiNew extends StatelessWidget {
  const ProfileUiNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => UserProfileBloc(sl<FetchUsers>(),
            sl<UpdateCurrentUser>(), sl<UploadProfileImageUser>())
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
                        Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                HotelBookingColors.buttoncolor,
                                HotelBookingColors.buttoncolor,
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

  Widget _buildInformationCard(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
          child: SizedBox(
            width: 310.0,
            height: 350.0,
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
                  SettingsInfoRow(
                    ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PrpageMyProfilePage(),
                      ));
                    },
                    icon: Icons.person,
                    label: "Profile",
                    // value: "Eating cakes",
                  ),
                  SettingsInfoRow(
                    ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ));
                    },
                    icon: Icons.settings,
                    label: 'Settings',
                    // value: "FairyTail, Magnolia",
                  ),
                  SettingsInfoRow(
                    ontap: () {},
                    icon: Icons.contact_support_sharp,
                    label: "Conatct US",
                    // value: "Eating cakes",
                  ),
                  SettingsInfoRow(
                    ontap: () {},
                    icon: Icons.question_answer,
                    label: "FAQs",
                    // value: "Team Natsu",
                  ),
                  SettingsInfoRow(
                    ontap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          titleText: 'Logout',
                          contentText: 'Are you sure you want to Logout?',
                          buttonText1: 'No',
                          buttonText2: 'Yes',
                          onPressButton1: () {
                            Navigator.of(context).pop();
                          },
                          onPressButton2: () async {
                            context.read<AuthBloc>().add(SignOutEvent());
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthSelectionPage()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      );
                      // context.read<AuthBloc>().add(SignOutEvent());
                      // Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(
                      //       builder: (context) => const AuthSelectionPage()),
                      //   (Route<dynamic> route) => false,
                      // );
                    },
                    icon: Icons.logout_rounded,
                    label: "Logout",
                    // value: "Team Natsu",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback ontap;

  const SettingsInfoRow(
      {super.key,
      required this.icon,
      required this.label,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, size: 35, color: HotelBookingColors.basictextcolor),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 15.0)),
                // Text(value!,
                //     style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
