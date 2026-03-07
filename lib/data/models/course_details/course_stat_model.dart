class CourseStatModel {
  final int totalEnrolled;
  final double attendanceRate;
  final double homeworkRate;
  final double avgGrade;
  final double overdueRate;

  CourseStatModel({
    required this.totalEnrolled,
    required this.attendanceRate,
    required this.homeworkRate,
    required this.avgGrade,
    required this.overdueRate,
  });

  factory CourseStatModel.fromJson(Map<String, dynamic> json) {
    return CourseStatModel(
      totalEnrolled: json['totalEnrolled'] as int,
      attendanceRate: (json['attendanceRate'] as num).toDouble(),
      homeworkRate: (json['homeworkRate'] as num).toDouble(),
      avgGrade: (json['avgGrade'] as num).toDouble(),
      overdueRate: (json['overdueRate'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEnrolled': totalEnrolled,
      'attendanceRate': attendanceRate,
      'homeworkRate': homeworkRate,
      'avgGrade': avgGrade,
      'overdueRate': overdueRate,
    };
  }
}