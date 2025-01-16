// import 'package:hotel_booking/features/report/data/datasource/report_datasourse.dart';
// import 'package:hotel_booking/features/report/data/model/report_model.dart';
// import 'package:hotel_booking/features/report/data/repositary/report_repositary.dart';

// class ReportRepositoryImpl implements ReportRepository {
//   final ReportDataSource remoteDataSource;

//   ReportRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<void> saveUserReport(ReportModel userData, String hotelId) async {
//     return await remoteDataSource.saveUserReport(userData, hotelId);
//   }

//   @override
//   Future<List<ReportModel>> getUserReports() async {
//     return await remoteDataSource.getUserReport();
//   }

//   @override
//   Future<List<ReportModel>> getAdminReports(String hotelId) async {
//     return await remoteDataSource.getAdminReports(hotelId);
//   }

//   @override
//   Future<void> deleteUserReport(String bookingId, String hotelId) async {
//     return await remoteDataSource.deleteUserReports(bookingId, hotelId);
//   }

//   @override
//   Future<ReportModel> getSingleUserReport(String bookingId) async {
//     return await remoteDataSource.getSingleUserReports(bookingId);
//   }
// }
