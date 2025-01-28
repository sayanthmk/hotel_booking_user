// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';

// class UserProfileModel {
//   final String id;
//   final String name;
//   final String email;
//   final Timestamp createdAt;
//   final String profileImage;
//   final String phoneNumber;
//   final String location;

//   const UserProfileModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.createdAt,
//     required this.profileImage,
//     required this.phoneNumber,
//     required this.location,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'createdAt': createdAt,
//       'profileImage': profileImage,
//       'phoneNumber': phoneNumber,
//       'location': location,
//     };
//   }

//   factory UserProfileModel.fromJson(Map<String, dynamic> map, String id) {
//     return UserProfileModel(
//       id: id,
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       createdAt: map['createdAt'] ?? Timestamp.now(),
//       profileImage: map['profileImage'] ?? '',
//       phoneNumber: map['phoneNumber'] ?? '',
//       location: map['location'] ?? '',
//     );
//   }
// }

// class FirebaseUserProfileDataSource {
//   final FirebaseFirestore firestore;

//   FirebaseUserProfileDataSource(this.firestore);

//   Future<UserProfileModel?> fetchUser() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       return null;
//     }

//     final snapshot =
//         await firestore.collection('users').doc(currentUser.uid).get();

//     if (snapshot.exists) {
//       return UserProfileModel.fromJson(snapshot.data()!, snapshot.id);
//     } else {
//       return null;
//     }
//   }

//   Future<void> updateCurrentUser(Map<String, dynamic> updatedData) async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       await firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .update(updatedData);
//     } else {
//       throw Exception("No authenticated user found.");
//     }
//   }
// }

// abstract class UserProfileRepository {
//   Future<UserProfileModel?> fetchUsers();
//   Future<void> updateCurrentUser(Map<String, dynamic> updatedData);
// }

// class UserProfileRepositoryImpl implements UserProfileRepository {
//   final FirebaseUserProfileDataSource dataSource;

//   UserProfileRepositoryImpl(this.dataSource);

//   @override
//   Future<UserProfileModel?> fetchUsers() async {
//     return await dataSource.fetchUser();
//   }

//   @override
//   Future<void> updateCurrentUser(Map<String, dynamic> updatedData) async {
//     await dataSource.updateCurrentUser(updatedData);
//   }
// }

// class FetchUsers {
//   final UserProfileRepository repository;

//   FetchUsers(this.repository);

//   Future<UserProfileModel?> call() async {
//     return await repository.fetchUsers();
//   }
// }

// class UpdateCurrentUser {
//   final UserProfileRepository repository;

//   UpdateCurrentUser(this.repository);

//   Future<void> call(Map<String, dynamic> updatedData) async {
//     await repository.updateCurrentUser(updatedData);
//   }
// }

// abstract class UserProfileEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LoadUsers extends UserProfileEvent {}

// class UpdateCurrentUserEvent extends UserProfileEvent {
//   final Map<String, dynamic> updatedData;

//   UpdateCurrentUserEvent(this.updatedData);

//   @override
//   List<Object?> get props => [updatedData];
// }

// abstract class UserProfileState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class UserInitial extends UserProfileState {}

// class UserLoading extends UserProfileState {}

// class UserLoaded extends UserProfileState {
//   final UserProfileModel user;

//   UserLoaded(this.user);

//   @override
//   List<Object?> get props => [user];
// }

// class UserError extends UserProfileState {
//   final String message;

//   UserError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
//   final FetchUsers fetchUsers;
//   final UpdateCurrentUser updateCurrentUser;

//   UserProfileBloc(this.fetchUsers, this.updateCurrentUser)
//       : super(UserInitial()) {
//     on<LoadUsers>((event, emit) async {
//       emit(UserLoading());
//       try {
//         final user = await fetchUsers();
//         if (user != null) {
//           emit(UserLoaded(user));
//         } else {
//           emit(UserError('User not found'));
//         }
//       } catch (e) {
//         emit(UserError(e.toString()));
//       }
//     });

//     on<UpdateCurrentUserEvent>((event, emit) async {
//       emit(UserLoading());
//       try {
//         await updateCurrentUser(event.updatedData);
//         final user = await fetchUsers();
//         if (user != null) {
//           emit(UserLoaded(user));
//         } else {
//           emit(UserError('User not found'));
//         }
//       } catch (e) {
//         emit(UserError(e.toString()));
//       }
//     });
//   }
// }


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