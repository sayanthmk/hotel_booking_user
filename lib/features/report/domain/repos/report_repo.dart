import 'dart:developer';
import 'package:hotel_booking/features/report/data/datasource/report_datasourse.dart';
import 'package:hotel_booking/features/report/data/model/report_model.dart';
import 'package:hotel_booking/features/report/data/repositary/report_repositary.dart';

class FirebaseIssueRepository implements IssueRepository {
  final FirebaseIssueDataSource dataSource;

  FirebaseIssueRepository(this.dataSource);

  @override
  Future<void> reportIssue(IssueModel issue, String hotelId) async {
    await dataSource.reportIssue(
      issue,
      hotelId,
    );
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
