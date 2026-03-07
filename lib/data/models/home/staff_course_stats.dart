class StaffCourseStats {

  final int totalCourses;
  final int totalStudents;

  StaffCourseStats({
    required this.totalCourses,
    required this.totalStudents
  });

  factory StaffCourseStats.fromJson(Map<String, dynamic> json) {
    return StaffCourseStats(
      totalCourses: json['totalAssignedCourses'] as int,
      totalStudents: json['totalUniqueStudents'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAssignedCourses': totalCourses,
      'totalUniqueStudents': totalStudents
    };
  }
}
