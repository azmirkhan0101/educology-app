import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class AnswerModel {
  final String answerId;
  final String taskId;
  final StaffModel student;
  final String courseId;
  final String answerPdf;
  final String submissionStatus;
  final int marks;
  final bool isMarked;
  final DateTime createdAt;

  AnswerModel({
    required this.answerId,
    required this.taskId,
    required this.student,
    required this.courseId,
    required this.answerPdf,
    required this.submissionStatus,
    required this.marks,
    required this.isMarked,
    required this.createdAt,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      answerId: json['_id'] ?? json['id'] ?? '',
      taskId: json['task'] != null ? json['task']['_id'] ?? '' : '',
      student: StaffModel.fromJson(json['student'] ?? {}),
      courseId: json['course'] ?? '',
      answerPdf: json['answerPdf'] ?? '',
      submissionStatus: json['submissionStatus'] ?? '',
      marks: json['marks'] is int ? json['marks'] : 0,
      isMarked: json['isMarked'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': answerId,
      'task': {'_id': taskId},
      'student': student.toJson(),
      'course': courseId,
      'answerPdf': answerPdf,
      'submissionStatus': submissionStatus,
      'marks': marks,
      'isMarked': isMarked,
      'createdAt': createdAt.toIso8601String()
    };
  }
}