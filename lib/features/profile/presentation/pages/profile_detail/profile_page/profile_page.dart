// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
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
                child: CircularProgressIndicator(color: AppColors.primary),
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
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardShadow,
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Colors.white,
                                  backgroundImage: selectedImage != null
                                      ? FileImage(selectedImage)
                                      : (imageUrl != null
                                          ? NetworkImage(imageUrl)
                                          : null) as ImageProvider?,
                                  child:
                                      selectedImage == null && imageUrl == null
                                          ? const Icon(Icons.person_rounded,
                                              size: 64,
                                              color: AppColors.textGrey)
                                          : null,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditUserProfile(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.edit_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Text(
                            user.name,
                            style: AppTextStyles.username.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: AppTextStyles.greeting.copyWith(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Account Details',
                              style: AppTextStyles.sectionTitle),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardShadow,
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfileCardWidget(
                            icon: Icons.person_rounded,
                            label: 'Name',
                            value: user.name,
                            iconColor: AppColors.primary,
                          ),
                          const CustDivider(),
                          ProfileCardWidget(
                            icon: Icons.mail_rounded,
                            label: 'Email',
                            value: user.email,
                            iconColor: AppColors.accent,
                          ),
                          const CustDivider(),
                          ProfileCardWidget(
                            icon: Icons.location_pin,
                            label: 'Location',
                            value: user.location,
                            iconColor: AppColors.primaryDark,
                          ),
                          const CustDivider(),
                          ProfileCardWidget(
                            icon: Icons.phone_rounded,
                            label: 'Phone Number',
                            value: user.phoneNumber,
                            iconColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Failed to load profile.',
                  style: AppTextStyles.hotelLocation,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
