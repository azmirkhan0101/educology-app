import '../staff/staff_model.dart';

class CourseModel {
  final String id;
  final String className;
  final String subjectName;
  final String imageUrl;
  final String status;
  final List<StudentModel> students;
  final int totalEnrolled;
  final StaffModel teacher;
  final StaffModel assistant;

  CourseModel({
    required this.id,
    required this.className,
    required this.subjectName,
    required this.imageUrl,
    required this.status,
    required this.students,
    required this.totalEnrolled,
    required this.teacher,
    required this.assistant,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'] ?? '',
      className: json['className'] ?? '',
      subjectName: json['subjectName'] ?? '',
      imageUrl: json['image'] ?? '',
      status: json['status'] ?? '',
      totalEnrolled: json['totalEnrolled'] ?? 0,
      students: (json['students'] as List?)
          ?.map((item) => StudentModel.fromJson(item))
          .toList() ?? [],
      teacher: StaffModel.fromJson(json['teacherId'] ?? {}),
      assistant: StaffModel.fromJson(json['assistantId'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'className': className,
      'subjectName': subjectName,
      'image': imageUrl,
      'status': status,
      'totalEnrolled': totalEnrolled,
      'students': students.map((e) => e.toJson()).toList(),
      'teacherId': teacher.toJson(),
      'assistantId': assistant.toJson(),
    };
  }
}

class StudentModel {
  final String id;
  final String fullName;
  final String image;
  final String email;
  final String contact;

  StudentModel({
    required this.id,
    required this.fullName,
    required this.image,
    required this.email,
    required this.contact
  });

  factory StudentModel.fromJson(Map<String, dynamic>? json) {

    if( json == null ){
      return StudentModel(
        id: "",
        fullName: "",
        image: "",
        email: "",
        contact: ""
      );
    }

    return StudentModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? "",
      email: json['email'] ?? '',
      contact: json['contact'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'image': image,
      'email': email,
      'contact': contact
    };
  }
}