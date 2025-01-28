import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/report/data/model/report_model.dart';
import 'package:hotel_booking/features/report/data/repositary/report_repositary.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_event.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_state.dart';

class ReportIssueBloc extends Bloc<ReportIssueEvent, ReportIssueState> {
  final IssueRepository issueRepository;
  // String? uploadedImageUrl;

  ReportIssueBloc(this.issueRepository) : super(ReportIssueInitialState()) {
    on<SubmitReportEvent>(_onSubmitReportEvent);
    on<FetchReportedIssuesEvent>(_onFetchReportedIssues);
    on<DeleteReportedIssueEvent>(_onDeleteReportedIssue);
    // on<ReportIssueImageEvent>(_onReportIssueImageEvent);
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
          reportImage: event.imageFile.toString());

      // Pass both issue and image file to repository
      await issueRepository.reportIssue(
          issue, event.hotelId, event.imageFile ?? File(''));
      log('bloc${event.imageFile.toString()}');
      emit(const ReportIssueSuccessState(
          successMessage: 'Issue reported successfully!'));
    } catch (e) {
      emit(ReportIssueFailureState(
          errorMessage: 'Failed to report the issue: $e'));
    }
  }

  Future<void> _onFetchReportedIssues(
    FetchReportedIssuesEvent event,
    Emitter<ReportIssueState> emit,
  ) async {
    emit(GetReportedIssuesLoading());
    try {
      final issues = await issueRepository.fetchReportedIssues(event.hotelId);
      emit(GetReportedIssuesLoaded(issues: issues));
    } catch (e) {
      emit(GetReportedIssuesError(errorMessage: 'Failed to fetch issues: $e'));
    }
  }

  Future<void> _onDeleteReportedIssue(
    DeleteReportedIssueEvent event,
    Emitter<ReportIssueState> emit,
  ) async {
    try {
      await issueRepository.deleteReportedIssue(event.issueId, event.hotelId);
      final currentState = state;
      if (currentState is GetReportedIssuesLoaded) {
        final updatedIssues = currentState.issues
            .where((issue) => issue.id != event.issueId)
            .toList();
        emit(GetReportedIssuesLoaded(issues: updatedIssues));
      }
    } catch (e) {
      emit(GetReportedIssuesError(errorMessage: 'Failed to delete issue: $e'));
    }
  }
}
