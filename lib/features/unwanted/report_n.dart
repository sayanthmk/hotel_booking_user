// import 'dart:developer';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:hotel_booking/features/report/presentation/pages/repor.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_bloc.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_event.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_state.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FirebaseIssueDataSource {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth auth;
//   final FirebaseStorage storage;

//   FirebaseIssueDataSource(this._firestore, this.auth, this.storage);

//   Future<void> reportIssue(
//       IssueModel issue, String hotelId, File? imageFile) async {
//     const uuid = Uuid();
//     try {
//       final User? currentUser = auth.currentUser;

//       if (currentUser == null) {
//         throw Exception('No authenticated user found');
//       }

//       String? downloadUrl;
//       if (imageFile != null && imageFile.path.isNotEmpty) {
//         final storageRef = storage.ref().child(
//             'reported_issues_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

//         final uploadTask = storageRef.putFile(imageFile);
//         final snapshot = await uploadTask;
//         downloadUrl = await snapshot.ref.getDownloadURL();
//       }

//       final String issueId = uuid.v4();
//       final String userEmail = currentUser.email!;
//       final issueRef = _firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('reported_issues')
//           .doc(issueId);

//       await issueRef.set({
//         'userId': currentUser.uid,
//         'hotelId': hotelId,
//         'issueId': issueId,
//         'userEmail': userEmail,
//         'reportImage': downloadUrl,
//         'issueDetails': {...issue.toMap(), 'reportImage': downloadUrl},
//       });

//       await _firestore
//           .collection('admin')
//           .doc(currentUser.uid)
//           .collection('reported_issues')
//           .doc(issueId)
//           .set({
//         'hotelId': hotelId,
//         'issueId': issueId,
//         'userEmail': userEmail,
//         'reportImage': downloadUrl,
//         'issueDetails': {...issue.toMap(), 'reportImage': downloadUrl},
//       });
//     } catch (e) {
//       throw Exception('Failed to report issue: $e');
//     }
//   }

//   // Future<void> reportIssue(IssueModel issue, String hotelId,File imageFile) async {
//   //   const uuid = Uuid();
//   //   try {
//   //     final User? currentUser = auth.currentUser;

//   //     if (currentUser == null) {
//   //       throw Exception('No authenticated user found');
//   //     }
//   //  final storageRef = storage.ref().child(
//   //       'reported_issues_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

//   //   // Upload the file
//   //   final uploadTask = storageRef.putFile(imageFile);
//   //   final snapshot = await uploadTask;

//   //   // Get the download URL
//   //   final downloadUrl = await snapshot.ref.getDownloadURL();

//   //     final String issueId = uuid.v4();
//   //     final String userEmail = currentUser.email!;
//   //     final issueRef = _firestore
//   //         .collection('users')
//   //         .doc(currentUser.uid)
//   //         .collection('reported_issues')
//   //         .doc(issueId);
//   //     log('Issue report datasource called');
//   //     await issueRef.set(
//   //       {
//   //         'userId': currentUser.uid,
//   //         'hotelId': hotelId,
//   //         'issueId': issueId,
//   //         'userEmail': userEmail,
//   //         'reportImage': downloadUrl,
//   //         'issueDetails': issue.toMap(),
//   //       },
//   //     );

//   //     await _firestore
//   //         .collection('admin')
//   //         .doc(currentUser.uid)
//   //         .collection('reported_issues')
//   //         .doc(issueId)
//   //         .set(
//   //       {
//   //         'hotelId': hotelId,
//   //         'issueId': issueId,
//   //         'userEmail': userEmail,
//   //         'reportImage': downloadUrl,
//   //         'issueDetails': issue.toMap(),
//   //       },
//   //     );
//   //   } catch (e) {
//   //     throw Exception('Failed to report issue: $e');
//   //   }
//   // }

//   Future<List<IssueModel>> fetchReportedIssues(String hotelId) async {
//     final User? currentUser = auth.currentUser;
//     final querySnapshot = await _firestore
//         .collection('users')
//         .doc(currentUser!.uid)
//         .collection('reported_issues')
//         .orderBy('issueDetails', descending: true)
//         .get();
//     return querySnapshot.docs
//         .map((doc) => IssueModel.fromMap(doc.data(), id: doc.id))
//         .toList();
//   }

//   Future<void> deleteReportedIssue(String issueId, String hotelId) async {
//     try {
//       final User? currentUser = auth.currentUser;
//       if (currentUser == null) {
//         throw Exception('No authenticated user found');
//       }

//       await _firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('reported_issues')
//           .doc(issueId)
//           .delete();

//       await _firestore
//           .collection('admin')
//           .doc(currentUser.uid)
//           .collection('reported_issues')
//           .doc(issueId)
//           .delete();

//       log('Issue reported deleted successfully');
//     } catch (e) {
//       throw Exception('Failed to delete reported issue: $e');
//     }
//   }

// //   Future<String> uploadReportImage(File imageFile, String issueId) async {
// //   final currentUser = FirebaseAuth.instance.currentUser;

// //   if (currentUser == null) {
// //     throw Exception("No authenticated user found.");
// //   }

// //   try {
// //     // Define the storage path
// //     final storageRef = storage.ref().child(
// //         'reported_issues_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

// //     // Upload the file
// //     final uploadTask = storageRef.putFile(imageFile);
// //     final snapshot = await uploadTask;

// //     // Get the download URL
// //     final downloadUrl = await snapshot.ref.getDownloadURL();

// //     // Update the user issues collection
// //     await _firestore
// //         .collection('users')
// //         .doc(currentUser.uid)
// //         .collection('reported_issues')
// //         .doc(issueId)
// //         .update({
// //       'reportImage': downloadUrl,
// //     });

// //     // Update the admin issues collection
// //     await _firestore
// //         .collection('admin')
// //         .doc(currentUser.uid) // Replace with your admin identifier logic
// //         .collection('reported_issues')
// //         .doc(issueId)
// //         .update({
// //       'reportImage': downloadUrl,
// //     });

// //     return downloadUrl;
// //   } catch (e) {
// //     throw Exception("Failed to upload image: $e");
// //   }
// // }
// }

// class IssueModel {
//   final String? id;
//   final String? hotelId;
//   final String? issueContent;
//   final DateTime? issueDate;
//   final String? userEmail;
//   final String? reportImage;

//   IssueModel({
//     this.id,
//     this.hotelId,
//     this.issueContent,
//     this.issueDate,
//     this.userEmail,
//     this.reportImage,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'issueDate': issueDate?.toIso8601String(),
//       'issue_content': issueContent,
//       'reportImage': reportImage,
//     };
//   }

//   factory IssueModel.fromMap(Map<String, dynamic> map,
//       {String? id, String? hotelId}) {
//     return IssueModel(
//         hotelId: map['hotelId'] ?? '',
//         id: id,
//         issueDate: (map['issueDate'] != null)
//             ? DateTime.parse(map['issueDate'])
//             : DateTime.now(),
//         issueContent: map['issue_content'] ?? '',
//         userEmail: map['userEmail'] ?? '',
//         reportImage: map['reportImage'] ?? '');
//   }
// }

// class FirebaseIssueRepository implements IssueRepository {
//   final FirebaseIssueDataSource dataSource;

//   FirebaseIssueRepository(this.dataSource);

//   @override
//   Future<void> reportIssue(
//       IssueModel issue, String hotelId, File imageFile) async {
//     await dataSource.reportIssue(issue, hotelId, imageFile);
//     log('Reported issue in repository');
//   }

//   @override
//   Future<List<IssueModel>> fetchReportedIssues(String hotelId) async {
//     return dataSource.fetchReportedIssues(hotelId);
//   }

//   @override
//   Future<void> deleteReportedIssue(String issueId, String hotelId) async {
//     await dataSource.deleteReportedIssue(issueId, hotelId);
//   }

//   // @override
//   // Future<String> uploadRepImage(File imageFile) async {
//   //   return await dataSource.uploadReportImage(imageFile);
//   // }
// }

// abstract class IssueRepository {
//   Future<void> reportIssue(IssueModel issue, String hotelId, File imageFile);
//   Future<List<IssueModel>> fetchReportedIssues(String hotelId);
//   Future<void> deleteReportedIssue(String issueId, String hotelId);
//   // Future<String> uploadRepImage(File imageFile);
// }
// import 'package:equatable/equatable.dart';

// abstract class ReportIssueEvent extends Equatable {
//   const ReportIssueEvent();

//   @override
//   List<Object> get props => [];
// }

// class ReportIssueImageEvent extends ReportIssueEvent {
//   final File imageFile;

//   const ReportIssueImageEvent(this.imageFile);

//   @override
//   List<Object> get props => [imageFile];
// }

// class SubmitReportEvent extends ReportIssueEvent {
//   final String issueContent;
//   final String hotelId;
//   final File? imageFile;

//   const SubmitReportEvent(
//       {required this.issueContent, required this.hotelId, this.imageFile});

//   @override
//   List<Object> get props =>
//       [issueContent, hotelId, if (imageFile != null) imageFile!];
// }

// class SubmitReportEvent extends ReportIssueEvent {
//   final String issueContent;
//   final String hotelId;

//   const SubmitReportEvent({required this.issueContent, required this.hotelId});

//   @override
//   List<Object> get props => [issueContent, hotelId];
// }

// / Additional supporting bloc for reported issues
// abstract class ReportedIssuesEvent extends Equatable {
//   const ReportedIssuesEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchReportedIssuesEvent extends ReportIssueEvent {
//   final String hotelId;
//   const FetchReportedIssuesEvent({required this.hotelId});

//   @override
//   List<Object> get props => [hotelId];
// }

// class DeleteReportedIssueEvent extends ReportIssueEvent {
//   final String issueId;
//   final String hotelId;
//   const DeleteReportedIssueEvent(
//       {required this.issueId, required this.hotelId});

//   @override
//   List<Object> get props => [issueId, hotelId];
// }
// import 'package:equatable/equatable.dart';

// abstract class ReportIssueState extends Equatable {
//   const ReportIssueState();

//   @override
//   List<Object> get props => [];
// }

// class ReportIssueImageUploadedState extends ReportIssueState {
//   final String imageUrl;

//   const ReportIssueImageUploadedState(this.imageUrl);

//   @override
//   List<Object> get props => [imageUrl];
// }

// class ReportIssueInitialState extends ReportIssueState {}

// class ReportIssueLoadingState extends ReportIssueState {}

// class ReportIssueSuccessState extends ReportIssueState {
//   final String successMessage;

//   const ReportIssueSuccessState({required this.successMessage});

//   @override
//   List<Object> get props => [successMessage];
// }

// class ReportIssueFailureState extends ReportIssueState {
//   final String errorMessage;

//   const ReportIssueFailureState({required this.errorMessage});

//   @override
//   List<Object> get props => [errorMessage];
// }

// class GetReportedIssuesInitial extends ReportIssueState {}

// class GetReportedIssuesLoading extends ReportIssueState {}

// class GetReportedIssuesLoaded extends ReportIssueState {
//   final List<IssueModel> issues;
//   const GetReportedIssuesLoaded({required this.issues});

//   @override
//   List<Object> get props => [issues];
// }

// class GetReportedIssuesError extends ReportIssueState {
//   final String errorMessage;
//   const GetReportedIssuesError({required this.errorMessage});

//   @override
//   List<Object> get props => [errorMessage];
// }

// import 'package:equatable/equatable.dart';

// class ReportIssueBloc extends Bloc<ReportIssueEvent, ReportIssueState> {
//   final IssueRepository issueRepository;
//   // String? uploadedImageUrl;

//   ReportIssueBloc(this.issueRepository) : super(ReportIssueInitialState()) {
//     on<SubmitReportEvent>(_onSubmitReportEvent);
//     on<FetchReportedIssuesEvent>(_onFetchReportedIssues);
//     on<DeleteReportedIssueEvent>(_onDeleteReportedIssue);
//     // on<ReportIssueImageEvent>(_onReportIssueImageEvent);
//   }

//   Future<void> _onSubmitReportEvent(
//     SubmitReportEvent event,
//     Emitter<ReportIssueState> emit,
//   ) async {
//     emit(ReportIssueLoadingState());

//     try {
//       final User? currentUser = FirebaseAuth.instance.currentUser;

//       if (currentUser == null) {
//         emit(const ReportIssueFailureState(
//             errorMessage: 'No authenticated user found'));
//         return;
//       }

//       final issue = IssueModel(
//         hotelId: event.hotelId,
//         issueContent: event.issueContent,
//         userEmail: currentUser.email!,
//         issueDate: DateTime.now(),
//       );

//       // Pass both issue and image file to repository
//       await issueRepository.reportIssue(
//           issue, event.hotelId, event.imageFile ?? File(''));

//       emit(const ReportIssueSuccessState(
//           successMessage: 'Issue reported successfully!'));
//     } catch (e) {
//       emit(ReportIssueFailureState(
//           errorMessage: 'Failed to report the issue: $e'));
//     }
//   }

//   Future<void> _onFetchReportedIssues(
//     FetchReportedIssuesEvent event,
//     Emitter<ReportIssueState> emit,
//   ) async {
//     emit(GetReportedIssuesLoading());
//     try {
//       final issues = await issueRepository.fetchReportedIssues(event.hotelId);
//       emit(GetReportedIssuesLoaded(issues: issues));
//     } catch (e) {
//       emit(GetReportedIssuesError(errorMessage: 'Failed to fetch issues: $e'));
//     }
//   }

//   Future<void> _onDeleteReportedIssue(
//     DeleteReportedIssueEvent event,
//     Emitter<ReportIssueState> emit,
//   ) async {
//     try {
//       await issueRepository.deleteReportedIssue(event.issueId, event.hotelId);
//       final currentState = state;
//       if (currentState is GetReportedIssuesLoaded) {
//         final updatedIssues = currentState.issues
//             .where((issue) => issue.id != event.issueId)
//             .toList();
//         emit(GetReportedIssuesLoaded(issues: updatedIssues));
//       }
//     } catch (e) {
//       emit(GetReportedIssuesError(errorMessage: 'Failed to delete issue: $e'));
//     }
//   }

//   // Future<void> _onReportIssueImageEvent(
//   //   ReportIssueImageEvent event,
//   //   Emitter<ReportIssueState> emit,
//   // ) async {
//   //   try {
//   //     final imageUrl = await issueRepository.uploadRepImage(event.imageFile);
//   //     _uploadedImageUrl = imageUrl;
//   //     emit(ReportIssueImageUploadedState(imageUrl));
//   //   } catch (e) {
//   //     emit(ReportIssueFailureState(errorMessage: 'Failed to upload image: $e'));
//   //   }
//   // }
// }

// class ReportIssuePage extends StatelessWidget {
//   const ReportIssuePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> predefinedIssues = [
//       "Room cleanliness issue",
//       "Faulty air conditioner",
//       "Unresponsive hotel staff",
//       "Incorrect booking details",
//       "Noisy environment",
//       "Wi-Fi not working",
//       "Overcharging issues",
//       "Uncomfortable bed",
//       "Hygiene issue",
//     ];

//     final TextEditingController customIssueController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Report an Issue'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.help_outline),
//             onPressed: () => _showHelpDialog(context),
//           ),
//           IconButton(
//               icon: const Icon(Icons.report),
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => ReportedIssuesPage(),
//                 ));
//               }),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Select a predefined issue or describe your own:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               flex: 3,
//               child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
//                 builder: (context, hotelState) {
//                   if (hotelState is SelectedHotelLoaded) {
//                     final hotelId = hotelState.hotel.hotelId;
//                     return ListView.builder(
//                       itemCount: predefinedIssues.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: ListTile(
//                             title: Text(predefinedIssues[index]),
//                             trailing: const Icon(Icons.report_problem,
//                                 color: Colors.red),
//                             onTap: () {
//                               _submitIssue(
//                                   context, predefinedIssues[index], hotelId);
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return const Center(child: CircularProgressIndicator());
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: customIssueController,
//                     decoration: InputDecoration(
//                       hintText: 'Describe your custom issue',
//                       suffixIcon: IconButton(
//                         icon: const Icon(Icons.send),
//                         onPressed: () {
//                           final customIssue = customIssueController.text.trim();
//                           if (customIssue.isNotEmpty) {
//                             final hotelId = (context
//                                     .read<SelectedHotelBloc>()
//                                     .state as SelectedHotelLoaded)
//                                 .hotel
//                                 .hotelId;
//                             _submitIssue(context, customIssue, hotelId);
//                             customIssueController.clear();
//                           }
//                         },
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     maxLines: 2,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.camera_alt),
//                   onPressed: () => _showImageSourceDialog(context),
//                 ),
//               ],
//             ),
//             BlocBuilder<ReportIssueBloc, ReportIssueState>(
//               builder: (context, state) {
//                 if (state is ReportIssueImageUploadedState) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Image.network(
//                       state.imageUrl,
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 }
//                 return const SizedBox();
//               },
//             ),
//             BlocConsumer<ReportIssueBloc, ReportIssueState>(
//               listener: (context, state) {
//                 if (state is ReportIssueSuccessState) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(state.successMessage),
//                       backgroundColor: Colors.green,
//                     ),
//                   );
//                 } else if (state is ReportIssueFailureState) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(state.errorMessage),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is ReportIssueLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return const SizedBox();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showImageSourceDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Choose Image Source'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera),
//               title: const Text('Camera'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 _pickImage(context, ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Gallery'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 _pickImage(context, ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _pickImage(BuildContext context, ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       context
//           .read<ReportIssueBloc>()
//           .add(ReportIssueImageEvent(File(pickedFile.path)));
//     }
//   }

//   void _submitIssue(BuildContext context, String issueContent, String hotelId) {
//     context.read<ReportIssueBloc>().add(
//           SubmitReportEvent(
//             issueContent: issueContent,
//             hotelId: hotelId,
//           ),
//         );
//   }

//   void _showHelpDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Reporting an Issue'),
//         content: const Text(
//           'You can:\n'
//           '• Select a predefined issue\n'
//           '• Write a custom issue description\n'
//           '• Provide specific details about your problem\n'
//           '• Add a supporting image\n'
//           'Our staff will review and address your concern promptly.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Understood'),
//           ),
//         ],
//       ),
//     );
//   }
// }




  // Future<String> uploadReportImage(File imageFile) async {
  //   final currentUser = FirebaseAuth.instance.currentUser;

  //   if (currentUser == null) {
  //     throw Exception("No authenticated user found.");
  //   }

  //   try {
  //     // Define the storage path
  //     final storageRef = storage.ref().child(
  //         'reported_issues_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

  //     // Upload the file
  //     final uploadTask = storageRef.putFile(imageFile);
  //     final snapshot = await uploadTask;

  //     // Get the download URL
  //     final downloadUrl = await snapshot.ref.getDownloadURL();

  //     // Update the most recently reported issue with the image URL
  //     final userIssuesQuery = await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('reported_issues')
  //         .orderBy('issueDate', descending: true)
  //         .limit(1)
  //         .get();

  //     final adminIssuesQuery = await _firestore
  //         .collection('admin')
  //         .doc(currentUser.uid)
  //         .collection('reported_issues')
  //         .orderBy('issueDate', descending: true)
  //         .limit(1)
  //         .get();

  //     // Update user issues collection
  //     if (userIssuesQuery.docs.isNotEmpty) {
  //       final latestUserIssueId = userIssuesQuery.docs.first.id;
  //       await _firestore
  //           .collection('users')
  //           .doc(currentUser.uid)
  //           .collection('reported_issues')
  //           .doc(latestUserIssueId)
  //           .update({
  //         'reportImage': downloadUrl,
  //       });
  //     }

  //     // Update admin issues collection
  //     if (adminIssuesQuery.docs.isNotEmpty) {
  //       final latestAdminIssueId = adminIssuesQuery.docs.first.id;
  //       await _firestore
  //           .collection('admin')
  //           .doc(currentUser.uid)
  //           .collection('reported_issues')
  //           .doc(latestAdminIssueId)
  //           .update({
  //         'reportImage': downloadUrl,
  //       });
  //     }

  //     return downloadUrl;
  //   } catch (e) {
  //     throw Exception("Failed to upload image: $e");
  //   }
  // }