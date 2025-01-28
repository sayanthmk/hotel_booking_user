import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/edit_profile_page.dart';
import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/widgets/profile_card.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';

class PrpageMyProfilePage extends StatelessWidget {
  const PrpageMyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileSectionColors.profilesecondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => UserProfileBloc(
          sl<FetchUsers>(),
          sl<UpdateCurrentUser>(),
          sl<UploadProfileImageUser>(),
        )..add(LoadUsers()),
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ProfileSectionColors.profileprimaryColor,
                            ProfileSectionColors.profileprimaryColor
                                .withOpacity(0.8),
                            ProfileSectionColors.accentColor,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/hotel_image.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    ProfileCard(
                      icon: Icons.person,
                      label: 'Name',
                      value: user.name,
                      iconColor: ProfileSectionColors.warningColor,
                    ),
                    ProfileCard(
                      icon: Icons.mail_rounded,
                      label: 'Email',
                      value: user.email,
                      iconColor: ProfileSectionColors.accentColor,
                    ),
                    ProfileCard(
                      icon: Icons.location_pin,
                      label: 'Location',
                      value: user.location,
                      iconColor: ProfileSectionColors.warningColor,
                    ),
                    ProfileCard(
                      icon: Icons.phone,
                      label: 'Phone Number',
                      value: user.phoneNumber,
                      iconColor: ProfileSectionColors.warningColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Failed to load profile.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const EditUserProfile(),
          ));
        },
        backgroundColor: ProfileSectionColors.accentColor,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class ProfileCustomColors {
//   static const Color profileCardBg = Colors.white;
//   static const Color profileprimaryColor = Colors.blue;
// }




  // Widget _buildProfileCard({
  //   required IconData icon,
  //   required String label,
  //   required String value,
  //   bool isFontAwesome = false,
  //   VoidCallback? onTap,
  //   Color? iconColor,
  // }) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: ProfileCustomColors.profileCardBg,
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.2),
  //           spreadRadius: 1,
  //           blurRadius: 15,
  //           offset: const Offset(0, 8),
  //         ),
  //       ],
  //     ),
  //     child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(20),
  //         onTap: onTap ?? () {},
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Row(
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color:
  //                       (iconColor ?? ProfileCustomColors.profileprimaryColor)
  //                           .withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 child: isFontAwesome
  //                     ? FaIcon(
  //                         icon,
  //                         color: iconColor ??
  //                             ProfileCustomColors.profileprimaryColor,
  //                         size: 24,
  //                       )
  //                     : Icon(
  //                         icon,
  //                         color: iconColor ??
  //                             ProfileCustomColors.profileprimaryColor,
  //                         size: 24,
  //                       ),
  //               ),
  //               const SizedBox(width: 20),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       label,
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         color: Colors.grey[600],
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 6),
  //                     Text(
  //                       value,
  //                       style: const TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.all(8),
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[100],
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Icon(
  //                   Icons.arrow_forward_ios,
  //                   color: Colors.grey[400],
  //                   size: 16,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // class ProfileCustomColors {
//   static const Color profileprimaryColor = Color(0xFF1E91B6);
//   static const Color profilesecondaryColor = Color(0xFFF5F9FF);
//   static const Color profileprimaryText = Color(0xFF000000);
//   static const Color profileCardBg = Colors.white;
//   static const Color accentColor = Color(0xFF00BFA5);
//   static const Color warningColor = Color(0xFFFFA726);
// }