import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class AttendanceFormModel {

  final StaffModel student;
  final String status;
  final String time;
  final String attendanceId;

  AttendanceFormModel({
    required this.student,
    required this.status,
    required this.time,
    required this.attendanceId
  });

  factory AttendanceFormModel.fromJson(Map<String, dynamic> json) {
    return AttendanceFormModel(
      student: StaffModel.fromJson(json['student']),
      status: json['status'] ?? "",
      time: json['time'] ?? "--:--",
      attendanceId: json['attendanceId'] ?? ""
    );
  }


}