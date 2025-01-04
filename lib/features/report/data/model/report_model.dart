class ReportModel {
  final String? id;
  final String? bookId;
  final String? hotelId;
  final String? reportcontent;
  final String? roomId;
  final DateTime? reportdate;

  ReportModel({
    this.id,
    this.bookId,
    this.hotelId,
    this.roomId,
    this.reportdate,
    this.reportcontent,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'reportdate': reportdate,
      'report_content': reportcontent,
    };
  }

  factory ReportModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
    String? hotelId,
  }) {
    final rpt = map['bookingDetails'];
    return ReportModel(
        bookId: map['bookingId'] ?? '',
        hotelId: map['hotelId'] ?? '',
        id: id,
        roomId: rpt['roomId'] ?? '',
        reportdate: rpt[DateTime.now()],
        reportcontent: rpt['report_content']);
  }
}
