import 'dart:io';

import 'package:hotel_booking/features/profile/data/model/profile_model.dart';

abstract class UserProfileRepository {
  Future<UserProfileModel?> fetchUsers();
  Future<void> updateCurrentUser(Map<String, dynamic> updatedData);
  Future<String> uploadImage(File imageFile);
}
