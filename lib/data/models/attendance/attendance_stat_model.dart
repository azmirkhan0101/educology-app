class AttendanceStatModel {
  final int onTimeCount;
  final double onTimePercentage;
  final int lateCount;
  final double latePercentage;
  final int absentCount;
  final double absentPercentage;

  AttendanceStatModel({
    required this.onTimeCount,
    required this.onTimePercentage,
    required this.lateCount,
    required this.latePercentage,
    required this.absentCount,
    required this.absentPercentage,
  });

  factory AttendanceStatModel.fromJson(Map<String, dynamic> json) {
    return AttendanceStatModel(
      onTimeCount: json['onTime']?['count'] ?? 0,
      onTimePercentage: ((json['onTime']?['percentage'] as num?) ?? 0).toDouble(),
      lateCount: json['late']?['count'] ?? 0,
      latePercentage: ((json['late']?['percentage'] as num?) ?? 0).toDouble(),
      absentCount: json['absent']?['count'] ?? 0,
      absentPercentage: ((json['absent']?['percentage'] as num?) ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'onTime': {
        'count': onTimeCount,
        'percentage': onTimePercentage,
      },
      'late': {
        'count': lateCount,
        'percentage': latePercentage,
      },
      'absent': {
        'count': absentCount,
        'percentage': absentPercentage,
      },
    };
  }
}