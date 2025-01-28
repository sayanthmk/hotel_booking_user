import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ReportIssueEvent extends Equatable {
  const ReportIssueEvent();

  @override
  List<Object> get props => [];
}

class SubmitReportEvent extends ReportIssueEvent {
  final String issueContent;
  final String hotelId;
  final File? imageFile;

  const SubmitReportEvent(
      {required this.issueContent, required this.hotelId, this.imageFile});

  @override
  List<Object> get props =>
      [issueContent, hotelId, if (imageFile != null) imageFile!];
}

class FetchReportedIssuesEvent extends ReportIssueEvent {
  final String hotelId;
  const FetchReportedIssuesEvent({required this.hotelId});

  @override
  List<Object> get props => [hotelId];
}

class DeleteReportedIssueEvent extends ReportIssueEvent {
  final String issueId;
  final String hotelId;
  const DeleteReportedIssueEvent(
      {required this.issueId, required this.hotelId});

  @override
  List<Object> get props => [issueId, hotelId];
}


// class ReportIssueImageEvent extends ReportIssueEvent {
//   final File imageFile;

//   const ReportIssueImageEvent(this.imageFile);

//   @override
//   List<Object> get props => [imageFile];
// }