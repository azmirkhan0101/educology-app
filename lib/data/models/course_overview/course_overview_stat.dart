class CourseOverviewStat {
  final int onTrack;
  final int attention;
  final int behind;
  final int critical;
  final int totalStudents;

  CourseOverviewStat({
    required this.onTrack,
    required this.attention,
    required this.behind,
    required this.critical,
    required this.totalStudents,
  });

  factory CourseOverviewStat.fromJson(Map<String, dynamic> json) {
    return CourseOverviewStat(
      onTrack: json['onTrack'],
      attention: json['attention'],
      behind: json['behind'],
      critical: json['critical'],
      totalStudents: json['totalStudents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'onTrack': onTrack,
      'attention': attention,
      'behind': behind,
      'critical': critical,
      'totalStudents': totalStudents
    };
  }
}
