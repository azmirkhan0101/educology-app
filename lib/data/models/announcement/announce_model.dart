import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class AnnounceModel {
  final String id;
  final String courseId;
  final String announce;
  final String document;
  final StaffModel teacher;
  final DateTime createdAt;
  final List<CommentModel> comments;

  AnnounceModel({
    required this.id,
    required this.courseId,
    required this.announce,
    required this.document,
    required this.teacher,
    required this.createdAt,
    required this.comments
  });

  factory AnnounceModel.fromJson(Map<String, dynamic> json) {
    return AnnounceModel(
      id: json['id'] ?? json['_id'] ?? "",
      courseId: json['courseId'] ?? "",
      announce: json['details'] ?? "",
      document: json['document'] ?? "",
      teacher: StaffModel.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>?)
                    ?.map((comment) => CommentModel.fromJson(comment))
                    .toList() ??
                []
          : [],
    );
  }
}
