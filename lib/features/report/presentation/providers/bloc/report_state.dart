import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/report/data/model/report_model.dart';

abstract class ReportIssueState extends Equatable {
  const ReportIssueState();

  @override
  List<Object> get props => [];
}

class ReportIssueImageUploadedState extends ReportIssueState {
  final String imageUrl;

  const ReportIssueImageUploadedState(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
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

class GetReportedIssuesInitial extends ReportIssueState {}

class GetReportedIssuesLoading extends ReportIssueState {}

class GetReportedIssuesLoaded extends ReportIssueState {
  final List<IssueModel> issues;
  const GetReportedIssuesLoaded({required this.issues});

  @override
  List<Object> get props => [issues];
}

class GetReportedIssuesError extends ReportIssueState {
  final String errorMessage;
  const GetReportedIssuesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
