import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class ClassModel {
  final String id;
  final List<String> documents;
  final String courseId;
  final String title;
  final DateTime startDate;
  final String startTime;
  final String details;
  final String link;
  final StaffModel teacher;
  final DateTime createdAt;
  final List<CommentModel> comments;

  ClassModel({
    required this.id,
    required this.documents,
    required this.courseId,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.details,
    required this.link,
    required this.teacher,
    required this.createdAt,
    required this.comments,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['_id'] ?? "",
      documents: json['documents'] != null ?
          (json['documents'] as List?)
              ?.map((item) => item.toString())
              .toList() ??
          [] : [],
      courseId: json['course'] ?? "",
      title: json['title'] ?? "",
      startDate: DateTime.parse(json['date']),
      startTime: json['time'] ?? "",
      details: json['details'] ?? "",
      link: json['link'] ?? "",
      teacher: StaffModel.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>?)?.map((e) {
                  return CommentModel.fromJson(e);
                }).toList() ??
                []
          : [],
    );
  }
}
