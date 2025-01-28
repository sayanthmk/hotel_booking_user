class IssueModel {
  final String? id;
  final String? hotelId;
  final String? issueContent;
  final DateTime? issueDate;
  final String? userEmail;

  IssueModel({
    this.id,
    this.hotelId,
    this.issueContent,
    this.issueDate,
    this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'issueDate': issueDate?.toIso8601String(),
      'issue_content': issueContent,
    };
  }

  factory IssueModel.fromMap(Map<String, dynamic> map,
      {String? id, String? hotelId}) {
    final issuerpt = map['issueDetails'];
    return IssueModel(
      hotelId: map['hotelId'] ?? '',
      id: id,
      issueDate: (issuerpt['issueDate'] != null)
          ? DateTime.parse(issuerpt['issueDate'])
          : DateTime.now(),
      issueContent: issuerpt['issue_content'] ?? '',
      userEmail: map['userEmail'] ?? '',
    );
  }
}
