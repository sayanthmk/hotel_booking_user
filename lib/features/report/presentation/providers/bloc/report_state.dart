import 'package:hotel_booking/features/report/data/model/report_model.dart';

abstract class ReportState {}

class UserReportInitialState extends ReportState {}

class UserReportLoadingState extends ReportState {}

class UserDataSavedState extends ReportState {}

class UserReportLoadedState extends ReportState {
  final List<ReportModel> userData;

  UserReportLoadedState(this.userData);
}

class UserReportErrorState extends ReportState {
  final String message;

  UserReportErrorState(this.message);
}

class UserBookingDeletedState extends ReportState {}

class SingleUserReportLoadedState extends ReportState {
  final ReportModel booking;
  SingleUserReportLoadedState(this.booking);
}
