class StudentStatusModel {
  final String id;
  final String fullName;
  final String image;
  final String contact;
  final String status;
  final double attendanceRate;
  final double avgGrade;
  final double homeworkCompletedRate;
  final double overdueRate;

  StudentStatusModel({
    required this.id,
    required this.fullName,
    required this.image,
    required this.contact,
    required this.status,
    required this.attendanceRate,
    required this.avgGrade,
    required this.homeworkCompletedRate,
    required this.overdueRate,
  });

  factory StudentStatusModel.fromJson(Map<String, dynamic> json) {

    final student = json['student'] as Map<String, dynamic>;

    return StudentStatusModel(
      id: student['_id'] ?? '',
      fullName: student['fullName'] ?? '',
      image: student['image'] ?? '',
      contact: student['contact'] ?? '',
      status: json['status'] ?? '',
      attendanceRate: ((json['attendanceRate'] as num?) ?? 0).toDouble(),
      avgGrade: ((json['avgGrade'] as num?) ?? 0).toDouble(),
      homeworkCompletedRate: ((json['homeworkCompletedRate'] as num?) ?? 0).toDouble(),
      overdueRate: ((json['overdueRate'] as num?) ?? 0).toDouble()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student': {
        '_id': id,
        'fullName': fullName,
        'image': image,
        'contact': contact,
      },
      'status': status,
      'attendanceRate': attendanceRate,
      'avgGrade': avgGrade,
      'homeworkCompletedRate': homeworkCompletedRate,
      'overdueRate': overdueRate
    };
  }
}