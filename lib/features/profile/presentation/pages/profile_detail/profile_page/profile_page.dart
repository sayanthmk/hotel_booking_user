// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/edit_profile/edit_profile_page.dart';
import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/profile_page/profile_card.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';

class PrpageMyProfilePage extends StatelessWidget {
  const PrpageMyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileSectionColors.secondary,
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
            String? imageUrl;
            File? selectedImage;
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ProfileSectionColors.primary,
                ),
              );
            } else if (state is UserLoaded) {
              final user = state.user;
              imageUrl = state.user.profileImage;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ProfileSectionColors.primary,
                            ProfileSectionColors.primaryLight,
                            ProfileSectionColors.accent,
                          ],
                          stops: [0.2, 0.5, 1.0],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ProfileSectionColors.primaryDark
                                .withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ProfileSectionColors.primaryDark
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: selectedImage != null
                                      ? FileImage(selectedImage)
                                      : (imageUrl != null
                                          ? NetworkImage(imageUrl)
                                          : null) as ImageProvider?,
                                  child:
                                      selectedImage == null && imageUrl == null
                                          ? const Icon(Icons.person,
                                              size: 70, color: Colors.grey)
                                          : null,
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
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: ProfileSectionColors.primaryDark
                                .withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfileCardWidget(
                            icon: Icons.person,
                            label: 'Name',
                            value: user.name,
                            iconColor: ProfileSectionColors.primary,
                          ),
                          const CustDivider(),
                          ProfileCardWidget(
                            icon: Icons.mail_rounded,
                            label: 'Email',
                            value: user.email,
                            iconColor: ProfileSectionColors.accent,
                          ),
                          const CustDivider(),
                          ProfileCardWidget(
                            icon: Icons.location_pin,
                            label: 'Location',
                            value: user.location,
                            iconColor: ProfileSectionColors.warning,
                          ),
                          const CustDivider(),
                          ProfileCardWidget(
                            icon: Icons.phone,
                            label: 'Phone Number',
                            value: user.phoneNumber,
                            iconColor: ProfileSectionColors.primaryLight,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Failed to load profile.',
                  style: TextStyle(
                    color: ProfileSectionColors.primaryDark,
                    fontSize: 16,
                  ),
                ),
              );
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
        backgroundColor: ProfileSectionColors.accent,
        elevation: 4,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
