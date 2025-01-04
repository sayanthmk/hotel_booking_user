import 'package:hotel_booking/features/report/data/model/report_model.dart';

abstract class ReportEvent {}

class SaveUserReportEvent extends ReportEvent {
  final ReportModel userData;
  final String hotelId;

  SaveUserReportEvent(this.userData, this.hotelId);
}

class GetUserReportEvent extends ReportEvent {}

class GetAdminReportsEvent extends ReportEvent {
  final String hotelId;

  GetAdminReportsEvent(this.hotelId);
}

class DeleteUserReportsEvent extends ReportEvent {
  final String bookingId;
  final String hotelId;

  DeleteUserReportsEvent(this.bookingId, this.hotelId);
}

class GetSingleUserReportsEvent extends ReportEvent {
  final String bookingId;
  GetSingleUserReportsEvent(this.bookingId);
}
