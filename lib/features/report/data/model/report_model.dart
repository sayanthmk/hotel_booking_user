class IssueModel {
  final String? id;
  final String? hotelId;
  final String? issueContent;
  final DateTime? issueDate;
  final String? userEmail;
  final String? reportImage;

  IssueModel({
    this.id,
    this.hotelId,
    this.issueContent,
    this.issueDate,
    this.userEmail,
    this.reportImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'issueDate': issueDate?.toIso8601String(),
      'issue_content': issueContent,
      'reportImage': reportImage,
    };
  }

  factory IssueModel.fromMap(Map<String, dynamic> map,
      {String? id, String? hotelId}) {
    return IssueModel(
        hotelId: map['hotelId'] ?? '',
        id: id,
        issueDate: (map['issueDate'] != null)
            ? DateTime.parse(map['issueDate'])
            : DateTime.now(),
        issueContent: map['issue_content'] ?? '',
        userEmail: map['userEmail'] ?? '',
        reportImage: map['reportImage'] ?? '');
  }
}
