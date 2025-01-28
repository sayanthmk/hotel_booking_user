import 'package:hotel_booking/features/report/data/model/report_model.dart';

abstract class IssueRepository {
  Future<void> reportIssue(IssueModel issue, String hotelId);
  Future<List<IssueModel>> fetchReportedIssues(String hotelId);
  Future<void> deleteReportedIssue(String issueId, String hotelId);
}
