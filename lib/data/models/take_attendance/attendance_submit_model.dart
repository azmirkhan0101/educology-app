class AttendanceSubmitModel {

  final String courseId;
  final String classId;
  final String studentId;
  final String date;
  final String time;
  final String status;

  AttendanceSubmitModel({
    required this.courseId,
    required this.classId,
    required this.studentId,
    required this.date,
    required this.time,
    required this.status
  });

  Map<String, String> toJson(){
    return {
      "course": courseId,
      "class": classId,
      "student": studentId,
      "date": date,
      "time": time,
      "status": status
    };
  }

}