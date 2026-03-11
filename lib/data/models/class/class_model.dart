import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class ClassModel {
  final String id;
  final List<dynamic> documents;
  final String course;
  final String title;
  final DateTime date;
  final String time;
  final String details;
  final String link;
  final StaffModel teacher;
  final DateTime createdAt;

  ClassModel({
    required this.id,
    required this.documents,
    required this.course,
    required this.title,
    required this.date,
    required this.time,
    required this.details,
    required this.link,
    required this.teacher,
    required this.createdAt
  });

  // Factory method to create a Lecture object from JSON
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['_id'] as String,
      documents: json['documents'] as List<dynamic>? ?? [],
      course: json['course'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      details: json['details'] as String,
      link: json['link'] as String,
      teacher: StaffModel.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt'] as String)
    );
  }

  // Method to convert a Lecture object back to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'course': course,
      'title': title,
      'date': date.toIso8601String(),
      'time': time,
      'details': details,
      'link': link,
      'createdBy': teacher,
      'createdAt': createdAt.toIso8601String()
    };
  }
}