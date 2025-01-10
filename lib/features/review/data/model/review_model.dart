class ReviewModel {
  final String? id;
  final String? bookId;
  final String? hotelId;
  final String? reviewcontent;
  final String? rating;
  final DateTime? reviewdate;

  ReviewModel({
    this.id,
    this.bookId,
    this.hotelId,
    this.reviewdate,
    this.reviewcontent,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'reviewdate': reviewdate,
      'review_content': reviewcontent,
      'rating': rating,
    };
  }

  factory ReviewModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
    String? hotelId,
  }) {
    final rpt = map['reviewDetails'];
    return ReviewModel(
        bookId: map['bookingId'] ?? '',
        hotelId: map['hotelId'] ?? '',
        id: id,
        reviewdate: rpt[DateTime.now()],
        rating: rpt['rating'] ?? '',
        reviewcontent: rpt['review_content']);
  }
}
