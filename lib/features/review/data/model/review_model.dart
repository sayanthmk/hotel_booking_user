class ReviewModel {
  final String? id;
  final String? bookId;
  final String? hotelId;
  final String? reviewcontent;

  final String? roomId;
  final DateTime? reviewdate;

  ReviewModel({
    this.id,
    this.bookId,
    this.hotelId,
    this.roomId,
    this.reviewdate,
    this.reviewcontent,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'reviewdate': reviewdate,
      'review_content': reviewcontent,
    };
  }

  factory ReviewModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
    String? hotelId,
  }) {
    final rpt = map['bookingDetails'];
    return ReviewModel(
        bookId: map['bookingId'] ?? '',
        hotelId: map['hotelId'] ?? '',
        id: id,
        roomId: rpt['roomId'] ?? '',
        reviewdate: rpt[DateTime.now()],
        reviewcontent: rpt['review_content']);
  }
}
