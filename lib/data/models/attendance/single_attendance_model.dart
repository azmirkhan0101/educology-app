class SingleAttendanceModel {

  final String className;
  final String classStart;
  final String status;

  SingleAttendanceModel({
    required this.className,
    required this.classStart,
    required this.status
  });

  factory SingleAttendanceModel.fromJson(Map<String, dynamic> json) {
    return SingleAttendanceModel(
      className: json['className'],
      classStart: json['classStart'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'classStart': classStart,
      'status': status
    };
  }

}