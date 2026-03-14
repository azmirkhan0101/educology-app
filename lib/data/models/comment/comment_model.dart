import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class CommentModel {
  final String id;
  final StaffModel? user;
  final String comment;
  final String announcementId;
  final String parentCommentId;
  final String classId;
  final String taskId;
  final DateTime createdAt;
  final List<CommentModel> replies;

  CommentModel({
    required this.id,
    this.user,
    required this.comment,
    required this.announcementId,
    required this.parentCommentId,
    required this.classId,
    required this.taskId,
    required this.createdAt,
    required this.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'] ?? json['id'] ?? "",
      user: json['user'] != null ? StaffModel.fromJson(json['user']) : null,
      comment: json['comment'] ?? "",
      announcementId: json['announcementId'] ?? "",
      parentCommentId: json['parentCommentId'] ?? "",
      classId: json['classId'] ?? "",
      taskId: json['taskId'] ?? "",
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now().toUtc(),
      replies: json['replies'] != null
          ? (json['replies'] as List<dynamic>?)?.map((reply) => CommentModel.fromJson(reply)).toList() ?? []
          : [],
    );
  }
}