import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class AnnounceModel {
  final String id;
  final String courseId;
  final String details;
  final String document;
  final StaffModel teacher;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> comments;

  AnnounceModel({
    required this.id,
    required this.courseId,
    required this.details,
    required this.document,
    required this.teacher,
    required this.createdAt,
    required this.updatedAt,
    required this.comments
  });

  factory AnnounceModel.fromJson(Map<String, dynamic> json) {
    return AnnounceModel(
      // Handling both "_id" and "id" from your JSON
      id: json['id'] ?? json['_id'],
      courseId: json['courseId'],
      details: json['details'] ?? "",
      document: json['document'] ?? "",
      teacher: StaffModel.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      comments: List<dynamic>.from(json['comments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'courseId': courseId,
      'details': details,
      'document': document,
      'createdBy': teacher.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'comments': comments,
      'id': id
    };
  }
}