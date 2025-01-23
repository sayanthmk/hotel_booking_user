import 'dart:io';
import 'package:hotel_booking/features/profile/data/datasource/profile_datasourse.dart';
import 'package:hotel_booking/features/profile/data/model/profile_model.dart';
import 'package:hotel_booking/features/profile/domain/repos/profile_repos.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final FirebaseUserProfileDataSource dataSource;

  UserProfileRepositoryImpl(this.dataSource);

  @override
  Future<UserProfileModel?> fetchUsers() async {
    return await dataSource.fetchUser();
  }

  @override
  Future<void> updateCurrentUser(Map<String, dynamic> updatedData) async {
    await dataSource.updateCurrentUser(updatedData);
  }

  @override
  Future<String> uploadImage(File imageFile) async {
    return await dataSource.uploadProfileImage(imageFile);
  }
}
