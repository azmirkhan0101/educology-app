import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class HomeworkExamModel {
  final String id;
  final String courseId;
  final String title;
  final String type;
  final DateTime startDate;
  final String startTime;
  final DateTime endDate;
  final String endTime;
  final String details;
  final StaffModel teacher;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;

  HomeworkExamModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.type,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.details,
    required this.teacher,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory HomeworkExamModel.fromJson(Map<String, dynamic> json) {
    return HomeworkExamModel(
      id: json['_id'] ?? json['id'],
      courseId: json['course'],
      title: json['title'],
      type: json['type'],
      // Parsing simple date strings
      startDate: DateTime.parse(json['startDate']),
      startTime: json['startTime'],
      endDate: DateTime.parse(json['endDate']),
      endTime: json['endTime'],
      details: json['details'],
      teacher: StaffModel.fromJson(json['createdBy']),
      // Parsing full ISO 8601 timestamps
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'course': courseId,
      'title': title,
      'type': type,
      'startDate': startDate.toIso8601String().split('T')[0],
      'startTime': startTime,
      'endDate': endDate.toIso8601String().split('T')[0],
      'endTime': endTime,
      'details': details,
      'createdBy': teacher.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
    };
  }
}