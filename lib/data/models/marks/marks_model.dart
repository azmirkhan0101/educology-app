
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

//DEADLINE IS STRING AND POSTEDAT IS DATETIME FROM BACKEND
class MarksModel {
  final String taskId;
  final String title;
  final String type;
  final String deadline;
  final String status;
  final bool isMarked;
  final int marks;
  final String? feedback;
  final String? correctAnswerPdf;
  final String? answerPdf;
  final StaffModel teacher;
  final DateTime postedAt;

  MarksModel({
    required this.taskId,
    required this.title,
    required this.type,
    required this.deadline,
    required this.status,
    required this.isMarked,
    required this.marks,
    this.feedback,
    this.correctAnswerPdf,
    this.answerPdf,
    required this.teacher,
    required this.postedAt,
  });

  // Factory method to create an ExamTask from JSON
  factory MarksModel.fromJson(Map<String, dynamic> json) {
    return MarksModel(
      taskId: json['taskId'] ?? "",
      title: json['title'] ?? "",
      type: json['type'] ?? "",
      deadline: json['deadline'] ?? "",
      status: json['status'] ?? "Not Submitted",
      isMarked: json['isMarked'] ?? false,
      marks: json['marks'] ?? 0,
      feedback: json['feedback'] ?? "",
      correctAnswerPdf: json['correctAnswerPdf'] ?? "",
      answerPdf: json['answerPdf'] ?? "",
      teacher: StaffModel.fromJson(json['teacher']),
      postedAt: DateTime.parse(json['postedAt'])
    );
  }

  // Method to convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'title': title,
      'type': type,
      'deadline': deadline,
      'status': status,
      'isMarked': isMarked,
      'marks': marks,
      'feedback': feedback,
      'correctAnswerPdf': correctAnswerPdf,
      'answerPdf': answerPdf,
      'teacher': teacher.toJson(),
      'postedAt': postedAt.toIso8601String()
    };
  }
}