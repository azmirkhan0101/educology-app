class StudentReportModel {
  final String studentName;
  final String attendance;
  final String hwCompleted;
  final String hwPending;
  final String examGrade;

  StudentReportModel({
    required this.studentName,
    required this.attendance,
    required this.hwCompleted,
    required this.hwPending,
    required this.examGrade
  });

  factory StudentReportModel.fromJson(Map<String, dynamic> json) {
    return StudentReportModel(
      studentName: json['studentName'] ?? '',
      attendance: json['attendance'] ?? '',
      hwCompleted: json['hwCompleted'] ?? '',
      hwPending: json['hwPending'] ?? '',
      examGrade: json['examGrade'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentName': studentName,
      'attendance': attendance,
      'hwCompleted': hwCompleted,
      'hwPending': hwPending,
      'examGrade': examGrade
    };
  }
}