import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/chatbot/chat_bot.dart';

class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final Timestamp createdAt;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> map, String id) {
    return UserProfileModel(
      id: id,
      name: map['name'] ?? 'name',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }
}

class FirebaseUserProfileDataSource {
  final FirebaseFirestore firestore;

  FirebaseUserProfileDataSource(this.firestore);

  Future<UserProfileModel?> fetchUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }

    final snapshot =
        await firestore.collection('users').doc(currentUser.uid).get();

    if (snapshot.exists) {
      return UserProfileModel.fromJson(snapshot.data()!, snapshot.id);
    } else {
      return null;
    }
  }

  Future<void> updateCurrentUser(Map<String, dynamic> updatedData) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(updatedData);
    } else {
      throw Exception("No authenticated user found.");
    }
  }
}

abstract class UserProfileRepository {
  Future<UserProfileModel?> fetchUsers();
  Future<void> updateCurrentUser(Map<String, dynamic> updatedData);
}

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
}

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

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final FetchUsers fetchUsers;
  final UpdateCurrentUser updateCurrentUser;

  UserProfileBloc(this.fetchUsers, this.updateCurrentUser)
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

    on<UpdateCurrentUserEvent>((event, emit) async {
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
    });
  }
}

class UserProfileListPage extends StatelessWidget {
  const UserProfileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HotelBookingChat(),
                ));
              },
              icon: const Icon(Icons.chat))
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            UserProfileBloc(sl<FetchUsers>(), sl<UpdateCurrentUser>())
              ..add(LoadUsers()),
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;
              return Container(
                child: Column(
                  children: [
                    Text(user.name),
                    Text(user.email),
                    Text(user.createdAt.toDate().toString()),
                    Text(user.id),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const UpdateCurrentUserDialog(),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No data found'));
          },
        ),
      ),
    );
  }
}

class UpdateCurrentUserDialog extends StatelessWidget {
  const UpdateCurrentUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    // final emailController = TextEditingController();

    return AlertDialog(
      title: const Text('Update Your Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          // TextField(
          //   controller: emailController,
          //   decoration: const InputDecoration(labelText: 'Email'),
          // ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedData = {
              'name': nameController.text,
              // 'email': emailController.text,
            };
            context
                .read<UserProfileBloc>()
                .add(UpdateCurrentUserEvent(updatedData));
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
    // return ListTile(
              //   title: Text(user.name),
              //   subtitle: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // Text(user.name),
              //       Text(user.email),
              //       Text(user.createdAt.toDate().toString()),
              //       Text(user.id),
              //     ],
              //   ),
              //   trailing: IconButton(
              //     icon: const Icon(Icons.edit),
              //     onPressed: () => showDialog(
              //       context: context,
              //       builder: (context) => const UpdateCurrentUserDialog(),
              //     ),
              //   ),
              // );