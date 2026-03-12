import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class ContentDetailsModel {

  final String title;
  final List<String> documents;
  final List<CommentModel> comments;
  final StaffModel teacher;
  final DateTime createdAt;
  final DateTime dueTime;

  ContentDetailsModel({
    required this.title,
    required this.documents,
    required this.comments,
    required this.teacher,
    required this.createdAt,
    required this.dueTime
  });
}