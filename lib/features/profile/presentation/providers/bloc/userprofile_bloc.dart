import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final FetchUsers fetchUsers;
  final UpdateCurrentUser updateCurrentUser;
  final UploadProfileImageUser uploadProfileImage;

  UserProfileBloc(
      this.fetchUsers, this.updateCurrentUser, this.uploadProfileImage)
      : super(UserInitial()) {
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

    on<UploadProfileImageEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final imageUrl = await uploadProfileImage(event.imageFile);
        final updatedData = {'profileImage': imageUrl};
        await updateCurrentUser(updatedData);
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
  }
}
