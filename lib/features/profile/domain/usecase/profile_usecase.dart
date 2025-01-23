import 'dart:io';

import 'package:hotel_booking/features/profile/data/model/profile_model.dart';
import 'package:hotel_booking/features/profile/domain/repos/profile_repos.dart';

class FetchUsers {
  final UserProfileRepository repository;

  FetchUsers(this.repository);

  Future<UserProfileModel?> call() async {
    return await repository.fetchUsers();
  }
}

class UpdateCurrentUser {
  final UserProfileRepository repository;

  UpdateCurrentUser(this.repository);

  Future<void> call(Map<String, dynamic> updatedData) async {
    await repository.updateCurrentUser(updatedData);
  }
}

class UploadProfileImageUser {
  final UserProfileRepository repository;

  UploadProfileImageUser(this.repository);

  Future<String> call(File imageFile) async {
    return await repository.uploadImage(imageFile);
  }
}
