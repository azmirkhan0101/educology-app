class StudentProgressModel {

  final double attendance;
  final double homework;
  final double avgGrade;
  final double overdue;
  final String? status;

  StudentProgressModel({
    required this.attendance,
    required this.homework,
    required this.avgGrade,
    required this.overdue,
    required this.status
  });

  factory StudentProgressModel.fromJson(Map<String, dynamic> json) {
    return StudentProgressModel(
      attendance: ((json['attendanceRate'] as num?) ?? 0).toDouble(),
      homework: ((json['homeworkCompletedRate'] as num?) ?? 0).toDouble(),
      avgGrade: ((json['avgGrade'] as num?) ?? 0).toDouble(),
      overdue: ((json['overdueRate'] as num?) ?? 0).toDouble(),
      status: json['status'] as String?
    );
  }
}