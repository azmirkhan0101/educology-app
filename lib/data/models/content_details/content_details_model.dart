import 'package:dr_dina_educology/data/models/class/class_model.dart';
import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

import '../homework_exam/homework_exam_model.dart';

class ContentDetailsModel {
  final String title;
  final List<String> documents;
  final List<CommentModel> comments;
  final StaffModel teacher;
  final DateTime createdAt;
  final DateTime startDate;
  final String startTime;
  final DateTime? endDate;
  final String? endTime;
  final String? classLink;
  final String? details;

  ContentDetailsModel({
    required this.title,
    required this.documents,
    required this.comments,
    required this.teacher,
    required this.createdAt,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.classLink,
    required this.details
  });

  factory ContentDetailsModel.fromClassModel(ClassModel classModel) {
    return ContentDetailsModel(
      title: classModel.title,
      documents: classModel.documents,
      comments: classModel.comments,
      teacher: classModel.teacher,
      createdAt: classModel.createdAt,
      startDate: classModel.startDate,
      startTime: classModel.startTime,
      endDate: null,
      endTime: null,
      classLink: classModel.link,
      details: classModel.details
    );
  }

  factory ContentDetailsModel.fromHomeworkExamModel(
    HomeworkExamModel homeworkExamModel,
  ) {
    return ContentDetailsModel(
      title: homeworkExamModel.title,
      documents: homeworkExamModel.documents,
      comments: homeworkExamModel.comments,
      teacher: homeworkExamModel.teacher,
      createdAt: homeworkExamModel.createdAt,
      startDate: homeworkExamModel.startDate,
      startTime: homeworkExamModel.startTime,
      endDate: homeworkExamModel.endDate,
      endTime: homeworkExamModel.endTime,
      classLink: null,
      details: homeworkExamModel.details
    );
  }
}
