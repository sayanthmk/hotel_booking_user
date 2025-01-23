import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final FetchUsers fetchUsers;
  final UpdateCurrentUser updateCurrentUser;
  final UploadProfileImageUser
      uploadProfileImage; // Added UploadProfileImage use case

  UserProfileBloc(
      this.fetchUsers, this.updateCurrentUser, this.uploadProfileImage)
      : super(UserInitial()) {
    // Load user profile
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await fetchUsers();
        if (user != null) {
          emit(UserLoaded(user));
        } else {
          emit(UserError('User not found'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // Update user profile
    on<UpdateCurrentUserEvent>(
      (event, emit) async {
        emit(UserLoading());
        try {
          await updateCurrentUser(event.updatedData);
          final user = await fetchUsers();
          if (user != null) {
            emit(UserLoaded(user));
          } else {
            emit(UserError('User not found'));
          }
        } catch (e) {
          emit(UserError(e.toString()));
        }
      },
    );

    // Upload profile image
    on<UploadProfileImageEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final imageUrl = await uploadProfileImage(event.imageFile);
        final updatedData = {
          'profileImage': imageUrl
        }; // Assuming this key is used in the database
        await updateCurrentUser(updatedData);
        final user = await fetchUsers();
        if (user != null) {
          emit(UserLoaded(user)); // Emit the updated user profile
        } else {
          emit(UserError('User not found'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
