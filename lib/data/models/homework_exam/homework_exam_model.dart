import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

import '../comment/comment_model.dart';

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
  final String status;
  final List<String> documents;
  final List<CommentModel> comments;
  String? userStatus;//"done" IF ROLE IS STUDENT AND STUDENT SUBMITTED THE TASK IN HW AND CLASS

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
    required this.status,
    required this.documents,
    required this.comments,
    required this.userStatus
  });

  factory HomeworkExamModel.fromJson(Map<String, dynamic> json) {
    return HomeworkExamModel(
      id: json['_id'] ?? json['id'] ?? "",
      courseId: json['course'] ?? "",
      title: json['title'] ?? "",
      type: json['type'] ?? "",
      // Parsing simple date strings
      startDate: DateTime.parse(json['startDate']),
      startTime: json['startTime'] ?? "",
      endDate: DateTime.parse(json['endDate']),
      endTime: json['endTime'] ?? "",
      details: json['details'] ?? "",
      teacher: StaffModel.fromJson(json['createdBy']),
      // Parsing full ISO 8601 timestamps
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'] ?? "",
      userStatus: json['userStatus']?.toString().toLowerCase(),
      documents: json['documents'] != null
          ? (json['documents'] as List<dynamic>?)
                    ?.map((document) => document as String)
                    .toList() ??
                []
          : [],
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>?)
                    ?.map((comment) => CommentModel.fromJson(comment))
                    .toList() ??
                []
          : [],
    );
  }
}
