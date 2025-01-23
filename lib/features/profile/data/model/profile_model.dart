import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final Timestamp createdAt;
  final String profileImage;
  final String phoneNumber;
  final String location;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.profileImage,
    required this.phoneNumber,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'profileImage': profileImage,
      'phone': phoneNumber,
      'location': location,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> map, String id) {
    return UserProfileModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      profileImage: map['profileImage'] ?? '',
      phoneNumber: map['phone'] ?? '',
      location: map['location'] ?? '',
    );
  }
}
