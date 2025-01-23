import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserProfileEvent {}

class UpdateCurrentUserEvent extends UserProfileEvent {
  final Map<String, dynamic> updatedData;

  UpdateCurrentUserEvent(this.updatedData);

  @override
  List<Object?> get props => [updatedData];
}

class UploadProfileImageEvent extends UserProfileEvent {
  final File imageFile;

  UploadProfileImageEvent(this.imageFile);
}
