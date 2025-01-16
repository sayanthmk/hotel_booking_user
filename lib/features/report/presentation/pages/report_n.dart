import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseIssueDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth auth;

  FirebaseIssueDataSource(this._firestore, this.auth);

  Future<void> reportIssue(IssueModel issue, String hotelId) async {
    const uuid = Uuid();
    try {
      final User? currentUser = auth.currentUser;

      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }
      final String issueId = uuid.v4();
      final String userEmail = currentUser.email!;
      final issueRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId);
      log('Issue report datasource called');
      await issueRef.set(
        {
          'userId': currentUser.uid,
          'hotelId': hotelId,
          'issueId': issueId,
          'userEmail': userEmail,
          'issueDetails': issue.toMap(),
        },
      );

      await _firestore
          .collection('admin')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId)
          .set(
        {
          'hotelId': hotelId,
          'issueId': issueId,
          'userEmail': userEmail,
          'issueDetails': issue.toMap(),
        },
      );
    } catch (e) {
      throw Exception('Failed to report issue: $e');
    }
  }

  Future<List<IssueModel>> fetchReportedIssues(String hotelId) async {
    final User? currentUser = auth.currentUser;
    final querySnapshot = await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('reported_issues')
        .orderBy('issueDetails', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => IssueModel.fromMap(doc.data(), id: doc.id))
        .toList();
  }

  Future<void> deleteReportedIssue(String issueId, String hotelId) async {
    try {
      final User? currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId)
          .delete();

      await _firestore
          .collection('admin')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId)
          .delete();

      log('Issue reported deleted successfully');
    } catch (e) {
      throw Exception('Failed to delete reported issue: $e');
    }
  }
}

class IssueModel {
  final String? id;
  final String? hotelId;
  final String? issueContent;
  final DateTime? issueDate;
  final String? userEmail;

  IssueModel({
    this.id,
    this.hotelId,
    this.issueContent,
    this.issueDate,
    this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'issueDate': issueDate?.toIso8601String(),
      'issue_content': issueContent,
    };
  }

  factory IssueModel.fromMap(Map<String, dynamic> map,
      {String? id, String? hotelId}) {
    return IssueModel(
      hotelId: map['hotelId'] ?? '',
      id: id,
      issueDate: (map['issueDate'] != null)
          ? DateTime.parse(map['issueDate'])
          : DateTime.now(),
      issueContent: map['issue_content'] ?? '',
      userEmail: map['userEmail'] ?? '',
    );
  }
}

class FirebaseIssueRepository implements IssueRepository {
  final FirebaseIssueDataSource dataSource;

  FirebaseIssueRepository(this.dataSource);

  @override
  Future<void> reportIssue(IssueModel issue, String hotelId) async {
    await dataSource.reportIssue(issue, hotelId);
    log('Reported issue in repository');
  }

  @override
  Future<List<IssueModel>> fetchReportedIssues(String hotelId) async {
    return dataSource.fetchReportedIssues(hotelId);
  }

  @override
  Future<void> deleteReportedIssue(String issueId, String hotelId) async {
    await dataSource.deleteReportedIssue(issueId, hotelId);
  }
}

abstract class IssueRepository {
  Future<void> reportIssue(IssueModel issue, String hotelId);
  Future<List<IssueModel>> fetchReportedIssues(String hotelId);
  Future<void> deleteReportedIssue(String issueId, String hotelId);
}

abstract class ReportIssueEvent extends Equatable {
  const ReportIssueEvent();

  @override
  List<Object> get props => [];
}

class SubmitReportEvent extends ReportIssueEvent {
  final String issueContent;
  final String hotelId;

  const SubmitReportEvent({required this.issueContent, required this.hotelId});

  @override
  List<Object> get props => [issueContent, hotelId];
}
// import 'package:equatable/equatable.dart';

abstract class ReportIssueState extends Equatable {
  const ReportIssueState();

  @override
  List<Object> get props => [];
}

class ReportIssueInitialState extends ReportIssueState {}

class ReportIssueLoadingState extends ReportIssueState {}

class ReportIssueSuccessState extends ReportIssueState {
  final String successMessage;

  const ReportIssueSuccessState({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class ReportIssueFailureState extends ReportIssueState {
  final String errorMessage;

  const ReportIssueFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ReportIssueBloc extends Bloc<ReportIssueEvent, ReportIssueState> {
  final IssueRepository issueRepository;

  ReportIssueBloc(this.issueRepository) : super(ReportIssueInitialState()) {
    on<SubmitReportEvent>(_onSubmitReportEvent);
  }

  Future<void> _onSubmitReportEvent(
    SubmitReportEvent event,
    Emitter<ReportIssueState> emit,
  ) async {
    emit(ReportIssueLoadingState());

    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        emit(const ReportIssueFailureState(
            errorMessage: 'No authenticated user found'));
        return;
      }

      final issue = IssueModel(
        hotelId: event.hotelId,
        issueContent: event.issueContent,
        userEmail: currentUser.email!,
        issueDate: DateTime.now(),
      );

      await issueRepository.reportIssue(issue, event.hotelId);

      emit(const ReportIssueSuccessState(
          successMessage: 'Issue reported successfully!'));
    } catch (e) {
      emit(ReportIssueFailureState(
          errorMessage: 'Failed to report the issue: $e'));
    }
  }
}

class ReportIssuePage extends StatelessWidget {
  const ReportIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> predefinedIssues = [
      "Room cleanliness issue",
      "Faulty air conditioner",
      "Unresponsive hotel staff",
      "Incorrect booking details",
      "Noisy environment",
      "Wi-Fi not working",
      "Overcharging issues",
      "Uncomfortable bed",
      "Hygiene issue",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report an Issue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a predefined issue or choose other:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
                builder: (context, hotelState) {
                  if (hotelState is SelectedHotelLoaded) {
                    final hotelId = hotelState.hotel.hotelId;
                    return ListView.builder(
                      itemCount: predefinedIssues.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(predefinedIssues[index]),
                          onTap: () {
                            context.read<ReportIssueBloc>().add(
                                  SubmitReportEvent(
                                    issueContent: predefinedIssues[index],
                                    hotelId: hotelId,
                                  ),
                                );
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            BlocConsumer<ReportIssueBloc, ReportIssueState>(
              listener: (context, state) {
                if (state is ReportIssueSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.successMessage),
                    backgroundColor: Colors.green,
                  ));
                } else if (state is ReportIssueFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              builder: (context, state) {
                if (state is ReportIssueLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
