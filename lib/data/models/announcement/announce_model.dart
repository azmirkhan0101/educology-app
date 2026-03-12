import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class AnnounceModel {
  final String id;
  final String courseId;
  final String announce;
  final StaffModel teacher;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CommentModel> comments;

  AnnounceModel({
    required this.id,
    required this.courseId,
    required this.announce,
    required this.teacher,
    required this.createdAt,
    required this.updatedAt,
    required this.comments
  });

  factory AnnounceModel.fromJson(Map<String, dynamic> json) {
    return AnnounceModel(
      id: json['id'] ?? json['_id'] ?? "",
      courseId: json['courseId'] ?? "",
      announce: json['details'] ?? "",
      teacher: StaffModel.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>?)
                    ?.map((comment) => CommentModel.fromJson(comment))
                    .toList() ??
                []
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'courseId': courseId,
      'details': announce,
      'createdBy': teacher.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'comments': comments,
      'id': id
    };
  }
}
