part of 'user_bloc.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserDataSavedState extends UserState {}

class UserDataLoadedState extends UserState {
  final List<UserDataModel> userData;

  UserDataLoadedState(this.userData);
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);
}

// New State for Deletion
class UserBookingDeletedState extends UserState {}
