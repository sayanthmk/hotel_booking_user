// profile_remote_datasource.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// profile_model.dart
class ProfileModel extends ProfileEntity {
  ProfileModel({
    super.userId,
    required super.name,
    required super.city,
    required super.phone,
    required super.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      city: json['cityState'] ?? '',
      phone: json['phone'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'cityState': city,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }
}

// profile_entity.dart
class ProfileEntity {
  final String? userId;
  final String name;
  final String city;
  final String phone;
  final String imageUrl;

  ProfileEntity({
    required this.userId,
    required this.name,
    required this.city,
    required this.phone,
    required this.imageUrl,
  });
}

// profile_repository.dart
// abstract class ProfileRepository {
//   Future<ProfileEntity> getProfile();
//   Future<void> updateProfile(ProfileModel profileData);
// }

// profile_usecases.dart
class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileEntity> call() {
    return repository.getProfile();
  }
}

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(ProfileModel profileData) {
    return repository.updateProfile(profileData);
  }
}
// Add this import at the top
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile(ProfileModel profileData);
  Future<String> uploadProfileImage(File imageFile);
}

class GetProfileRemoteDataSource implements ProfileRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;

  GetProfileRemoteDataSource(this._firestore, this._auth)
      : _storage = FirebaseStorage.instance;

  @override
  Future<ProfileModel> getProfile() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception('No authenticated user found');

    try {
      final docSnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (!docSnapshot.exists) {
        throw Exception('Profile not found');
      }

      return ProfileModel.fromJson({...docSnapshot.data()!});
    } catch (e) {
      throw Exception('Failed to fetch Profile: $e');
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profileData) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception('No authenticated user found');

    try {
      await _firestore.collection('users').doc(currentUser.uid).update(
            profileData.toJson(),
          );
    } catch (e) {
      throw Exception('Failed to update Profile: $e');
    }
  }

  @override
  Future<String> uploadProfileImage(File imageFile) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception('No authenticated user found');

    try {
      // Create a reference to the image path
      final String fileName =
          'profile_images/${currentUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef = _storage.ref().child(fileName);

      // Upload the file
      final UploadTask uploadTask = storageRef.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'userId': currentUser.uid,
            'uploadDate': DateTime.now().toIso8601String(),
          },
        ),
      );

      // Get the download URL
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Update the user's profile with the new image URL
      await _firestore.collection('users').doc(currentUser.uid).update({
        'imageUrl': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileDataSource;

  ProfileRepositoryImpl(this.profileDataSource);

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      return await profileDataSource.getProfile();
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profileData) async {
    try {
      await profileDataSource.updateProfile(profileData);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<String> uploadProfileImage(File imageFile) async {
    try {
      return await profileDataSource.uploadProfileImage(imageFile);
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }
}

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
  Future<void> updateProfile(ProfileModel profileData);
  Future<String> uploadProfileImage(File imageFile);
}

// Add new use case for image upload
class UploadProfileImageUseCase {
  final ProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  Future<String> call(File imageFile) {
    return repository.uploadProfileImage(imageFile);
  }
}

// profile_event.dart
abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String city;
  final String phone;

  UpdateProfileEvent({
    required this.name,
    required this.city,
    required this.phone,
  });
}

class UploadProfileImageEvent extends ProfileEvent {
  final File imageFile;

  UploadProfileImageEvent(this.imageFile);
}

// profile_state.dart
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ImageUploadSuccess extends ProfileState {
  final String imageUrl;

  ImageUploadSuccess(this.imageUrl);
}

// profile_bloc.dart
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.uploadProfileImageUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileEvent>(_handleGetProfile);
    on<UpdateProfileEvent>(_handleUpdateProfile);
    on<UploadProfileImageEvent>(_handleUploadProfileImage);
  }

  Future<void> _handleGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _handleUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profileModel = ProfileModel(
        name: event.name,
        city: event.city,
        phone: event.phone,
        imageUrl: (state as ProfileLoaded).profile.imageUrl,
      );
      await updateProfileUseCase(profileModel);
      final updatedProfile = await getProfileUseCase();
      emit(ProfileLoaded(updatedProfile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _handleUploadProfileImage(
    UploadProfileImageEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final imageUrl = await uploadProfileImageUseCase(event.imageFile);
      emit(ImageUploadSuccess(imageUrl));
      add(GetProfileEvent()); // Refresh profile after image upload
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

// // profile_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileEditPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is ProfileLoaded) {
            final profile = state.profile;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: profile.imageUrl == null
                            ? NetworkImage(profile.imageUrl)
                            : null,
                        child: profile.imageUrl == null
                            ? const Icon(Icons.person, size: 60)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () async {
                          // Implement image picker logic here
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            context
                                .read<ProfileBloc>()
                                .add(UploadProfileImageEvent(File(image.path)));
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Name'),
                    subtitle: Text(profile.name),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_city),
                    title: const Text('City'),
                    subtitle: Text(profile.city),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(profile.phone),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// profile_edit_page.dart
class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final cityController = TextEditingController();
    final phoneController = TextEditingController();

    // Pre-fill the form if profile is loaded
    if (context.read<ProfileBloc>().state is ProfileLoaded) {
      final profile =
          (context.read<ProfileBloc>().state as ProfileLoaded).profile;
      nameController.text = profile.name;
      cityController.text = profile.city;
      phoneController.text = profile.phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.pop(context);
          }
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    icon: Icon(Icons.location_city),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    icon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: state is ProfileLoading
                      ? null
                      : () {
                          context.read<ProfileBloc>().add(
                                UpdateProfileEvent(
                                  name: nameController.text,
                                  city: cityController.text,
                                  phone: phoneController.text,
                                ),
                              );
                        },
                  child: state is ProfileLoading
                      ? const CircularProgressIndicator()
                      : const Text('Save Changes'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
