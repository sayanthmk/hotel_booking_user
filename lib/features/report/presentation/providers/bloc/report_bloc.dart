// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/report/data/repositary/report_repositary.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_event.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_state.dart';

// class ReportBloc extends Bloc<ReportEvent, ReportState> {
//   final ReportRepository repository;

//   ReportBloc(this.repository) : super(UserReportInitialState()) {
//     on<SaveUserReportEvent>(_onSaveUserReport);
//     on<GetUserReportEvent>(_onGetUserReports);
//     on<GetAdminReportsEvent>(_onGetAdminReports);
//     on<DeleteUserReportsEvent>(_onDeleteUserReports);
//     on<GetSingleUserReportsEvent>(_onGetSingleUserReports);
//   }

//   void _onSaveUserReport(
//       SaveUserReportEvent event, Emitter<ReportState> emit) async {
//     try {
//       emit(UserReportLoadingState());

//       await repository.saveUserReport(event.userData, event.hotelId);
//       emit(UserDataSavedState());
//     } catch (e) {
//       emit(UserReportErrorState('Failed to save user data: $e'));
//     }
//   }

//   void _onGetUserReports(
//       GetUserReportEvent event, Emitter<ReportState> emit) async {
//     try {
//       emit(UserReportLoadingState());
//       final userData = await repository.getUserReports();
//       emit(UserReportLoadedState(userData));
//     } catch (e) {
//       emit(UserReportErrorState('Failed to load user data: $e'));
//     }
//   }

//   void _onGetAdminReports(
//       GetAdminReportsEvent event, Emitter<ReportState> emit) async {
//     try {
//       emit(UserReportLoadingState());
//       final adminReports = await repository.getAdminReports(event.hotelId);
//       emit(UserReportLoadedState(adminReports));
//     } catch (e) {
//       emit(UserReportErrorState('Failed to load hotel bookings: $e'));
//     }
//   }

//   void _onDeleteUserReports(
//       DeleteUserReportsEvent event, Emitter<ReportState> emit) async {
//     try {
//       emit(UserReportLoadingState());
//       await repository.deleteUserReport(event.bookingId, event.hotelId);
//       emit(UserBookingDeletedState());
//       add(GetUserReportEvent());
//     } catch (e) {
//       emit(UserReportErrorState('Failed to delete user booking: $e'));
//     }
//   }

//   void _onGetSingleUserReports(
//       GetSingleUserReportsEvent event, Emitter<ReportState> emit) async {
//     try {
//       emit(UserReportLoadingState());
//       final booking = await repository.getSingleUserReport(event.bookingId);
//       emit(SingleUserReportLoadedState(booking));
//     } catch (e) {
//       emit(UserReportErrorState('Failed to load single user booking: $e'));
//     }
//   }
// }
