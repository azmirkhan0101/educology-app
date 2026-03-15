import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

class TakeAttendanceModel {

  final StaffModel student;
  final String status;
  final String time;
  final String attendanceId;

  TakeAttendanceModel({
    required this.student,
    required this.status,
    required this.time,
    required this.attendanceId
  });

  factory TakeAttendanceModel.fromJson(Map<String, dynamic> json) {
    return TakeAttendanceModel(
      student: StaffModel.fromJson(json['student']),
      status: json['status'] ?? "",
      time: json['time'] ?? "--:--",
      attendanceId: json['attendanceId'] ?? ""
    );
  }


}