import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/profile/data/model/profile_model.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserProfileState {}

class UserLoading extends UserProfileState {}

class UserLoaded extends UserProfileState {
  final UserProfileModel user;

  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserProfileState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileImageUploadedState extends UserProfileState {
  final String imageUrl;

  ProfileImageUploadedState(this.imageUrl);
}
