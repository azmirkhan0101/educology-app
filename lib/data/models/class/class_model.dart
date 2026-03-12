import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class ClassModel {
  final String id;
  final List<String> documents;
  final String courseId;
  final String title;
  final DateTime endDate;
  final String time;
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
    required this.endDate,
    required this.time,
    required this.details,
    required this.link,
    required this.teacher,
    required this.createdAt,
    required this.comments,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['_id'] as String,
      documents: json['documents'] != null ?
          (json['documents'] as List?)
              ?.map((item) => item.toString())
              .toList() ??
          [] : [],
      courseId: json['course'] as String,
      title: json['title'] as String,
      endDate: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      details: json['details'] as String,
      link: json['link'] as String,
      teacher: StaffModel.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>?)?.map((e) {
                  return CommentModel.fromJson(e);
                }).toList() ??
                []
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'course': courseId,
      'title': title,
      'date': endDate.toIso8601String(),
      'time': time,
      'details': details,
      'link': link,
      'createdBy': teacher,
      'createdAt': createdAt.toIso8601String(),
      'comments': comments,
      'id': id,
    };
  }
}
