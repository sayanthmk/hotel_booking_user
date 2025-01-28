import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/validator/validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';

class EditUserProfile extends StatelessWidget {
  const EditUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    final phoneController = TextEditingController();

    void pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        // ignore: use_build_context_synchronously
        context
            .read<UserProfileBloc>()
            .add(UploadProfileImageEvent(File(pickedFile.path)));
      }
    }

    void showImagePickerModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        backgroundColor: ProfileSectionColors.surfaceColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Change Profile Picture',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ProfileSectionColors.primaryDark,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ProfileSectionColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.photo_library,
                      color: ProfileSectionColors.accent),
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ProfileSectionColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.camera_alt,
                      color: ProfileSectionColors.primary),
                ),
                title: const Text('Take a Photo'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => UserProfileBloc(
        sl<FetchUsers>(),
        sl<UpdateCurrentUser>(),
        sl<UploadProfileImageUser>(),
      )..add(LoadUsers()),
      child: Scaffold(
        backgroundColor: ProfileSectionColors.secondary,
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: ProfileSectionColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ProfileSectionColors.primary,
                ),
              );
            } else if (state is UserLoaded) {
              final user = state.user;

              nameController.text = user.name;
              locationController.text = user.location;
              phoneController.text = user.phoneNumber;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            color: ProfileSectionColors.primary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ProfileSectionColors.primaryDark
                                      .withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  // backgroundImage:
                                  //     NetworkImage(user.profileImage),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => showImagePickerModal(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: ProfileSectionColors.accent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 90),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              buildTextField(
                                controller: nameController,
                                label: 'Full Name',
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 20),
                              buildTextField(
                                controller: locationController,
                                label: 'Location',
                                icon: Icons.location_on,
                              ),
                              const SizedBox(height: 20),
                              buildTextField(
                                controller: phoneController,
                                label: 'Phone Number',
                                icon: Icons.phone,
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final updatedData = {
                                      'name': nameController.text,
                                      'location': locationController.text,
                                      'phone': phoneController.text,
                                    };
                                    context.read<UserProfileBloc>().add(
                                        UpdateCurrentUserEvent(updatedData));
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ProfileSectionColors.accent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Save Changes',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Text(
                  state.message,
                  style:
                      const TextStyle(color: ProfileSectionColors.primaryDark),
                ),
              );
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      validator: CustomValidator.validateRequired,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: ProfileSectionColors.primaryDark.withOpacity(0.6)),
        prefixIcon: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            color: ProfileSectionColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ProfileSectionColors.primaryDark.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ProfileSectionColors.primary,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
