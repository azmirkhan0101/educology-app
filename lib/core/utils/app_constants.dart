import 'dart:ui';

import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../assets_gen/assets.gen.dart';
import 'api_endpoints.dart';
import 'app_strings.dart';

//GET STORAGE KEYS
const String isSignupKey = "isSignupKey";
const String isLoginKey = "isLoginKey";
const String emailKey = "emailKey";
const String accessTokenKey = "accessTokenKey";
const String refreshTokenKey = "refreshTokenKey";
const String requireVerificationKey = "requireVerificationKey";
const String forgotPasswordTokenKey = "forgotPasswordTokenKey";
const String profileModelKey = "profileModelKey";
const String userNameKey = "userNameKey";
const String userContactKey = "userContactKey";

//AUTH STATUS
enum AuthStatus {
  loggedInAndVerified,
  loggedInNotVerified,
  loggedOut
}

//ROLES
enum Role {
  teacher,
  assistant,
  student,
  parent;

  static Role fromString(String role) {
    return Role.values.firstWhere(
          (e) => e.name == role.toLowerCase(),
      orElse: () => Role.student,
    );
  }

  String toJson() => name;
}

//INFO SCREEN TYPE
enum InfoPageType {
  privacyPolicy,
  termsAndConditions,
  aboutUs,
}

extension InfoPageTypeExtension on InfoPageType {
  String get label {
    switch (this) {
      case InfoPageType.privacyPolicy:
        return AppStrings.privacyPolicy;
      case InfoPageType.termsAndConditions:
        return AppStrings.termsConditions;
      case InfoPageType.aboutUs:
        return AppStrings.aboutUs;
    }
  }
  //ENDPOINT BASED ON TYPE
  String get endPoint {
    switch (this) {
      case InfoPageType.privacyPolicy:
        return ApiEndpoints.privacyPolicy;
      case InfoPageType.termsAndConditions:
        return ApiEndpoints.termsAndConditions;
      case InfoPageType.aboutUs:
        return ApiEndpoints.aboutUs;
    }
  }
  //FOR PARSING DATA FROM API
  String get parseKey {
    switch (this) {
      case InfoPageType.privacyPolicy:
        return 'privacyPolicy';
      case InfoPageType.termsAndConditions:
        return 'termsCondition';
      case InfoPageType.aboutUs:
        return 'aboutUs';
    }
  }
}


//USER STATUS - IN PROGRESS, BLOCKED, PENDING
enum UserStatus {
  inProgress,
  blocked,
  pending;

  static UserStatus fromString(String status) {
    return UserStatus.values.firstWhere(
          (e) => e.name.toLowerCase() == status.replaceAll('-', '').toLowerCase(),
      orElse: () => UserStatus.inProgress,
    );
  }

  String toJson() => name.replaceAll(RegExp(r'(?=[A-Z])'), '-').toLowerCase();
}

const String roleKey = "roleKey";

//STUDENT STATUS - ON TRACK, ATTENTION, BEHIND, CRITICAL
//on track', 'behind', 'attention', 'critical'
enum StudentStatus { onTrack, attention, behind, critical }

extension StatusColorExtension on StudentStatus {

  String get iconPath {
    switch (this) {
      case StudentStatus.onTrack: return Assets.icons.onTrack;
      case StudentStatus.attention: return Assets.icons.attention;
      case StudentStatus.behind: return Assets.icons.behind;
      case StudentStatus.critical: return Assets.icons.critical;
    }
  }

  Color get bgColor {
    switch (this) {
      case StudentStatus.onTrack: return const Color(0xFFF1FAF5);
      case StudentStatus.attention: return const Color(0xFFFFF9E6);
      case StudentStatus.behind: return const Color(0x26E68600);
      case StudentStatus.critical: return const Color(0x26F70004);
    }
  }

  Color get primaryColor {
    switch (this) {
      case StudentStatus.onTrack: return const Color(0xFF28A745);
      case StudentStatus.attention: return const Color(0xFFFFC107);
      case StudentStatus.behind: return const Color(0xFFDC3545);
      case StudentStatus.critical: return const Color(0xFFF70004);
    }
  }

  String get label {
    switch (this) {
      case StudentStatus.onTrack: return AppStrings.onTrack;
      case StudentStatus.attention: return AppStrings.needsAttention;
      case StudentStatus.behind: return AppStrings.fallingBehind;
      case StudentStatus.critical: return AppStrings.criticalRisk;
    }
  }

  String get label2 {
    switch (this) {
      case StudentStatus.onTrack: return AppStrings.onTrack;
      case StudentStatus.attention: return AppStrings.attention;
      case StudentStatus.behind: return AppStrings.behind;
      case StudentStatus.critical: return AppStrings.critical;
    }
  }

  String get label3 {
    switch (this) {
      case StudentStatus.onTrack: return "on track";
      case StudentStatus.attention: return "attention";
      case StudentStatus.behind: return "behind";
      case StudentStatus.critical: return "critical";
    }
  }

}

//ATTENDANCE STATUS - ON TIME, LATE, ABSENT
//['absent', 'late', 'on time' 'Not Marked']
enum AttendanceStatus{ onTime, absent, late, notMarked}

extension AttendanceStatusColorExtension on AttendanceStatus {

  String get label {
    switch (this) {
      case AttendanceStatus.onTime: return "On Time";
      case AttendanceStatus.late: return "Late";
      case AttendanceStatus.absent: return "Absent";
      case AttendanceStatus.notMarked: return "Not Marked";
    }
  }

  String get label2 {
    switch (this) {
      case AttendanceStatus.onTime: return "on time";
      case AttendanceStatus.late: return "late";
      case AttendanceStatus.absent: return "absent";
      case AttendanceStatus.notMarked: return "Not Marked";
    }
  }

  Color get statusColor {
    switch (this) {
      case AttendanceStatus.onTime: return Colors.green;
      case AttendanceStatus.late: return Colors.orange;
      case AttendanceStatus.absent: return Colors.red;
      case AttendanceStatus.notMarked: return Colors.yellow.shade900;
    }
  }
}

//TAKE ATTENDANCE
enum TakeAttendanceStatus{ onTime, absent, late, notMarked}

extension TakeAttendanceStatusColorExtension on TakeAttendanceStatus {

  String get label {
    switch (this) {
      case TakeAttendanceStatus.onTime: return "On Time";
      case TakeAttendanceStatus.late: return "Late";
      case TakeAttendanceStatus.absent: return "Absent";
      case TakeAttendanceStatus.notMarked: return "Not Marked";
    }
  }

  String get label2 {
    switch (this) {
      case TakeAttendanceStatus.onTime: return "on time";
      case TakeAttendanceStatus.late: return "late";
      case TakeAttendanceStatus.absent: return "absent";
      case TakeAttendanceStatus.notMarked: return "Not Marked";
    }
  }

  Color get statusColor {
    switch (this) {
      case TakeAttendanceStatus.onTime: return Colors.green;
      case TakeAttendanceStatus.late: return Colors.orange;
      case TakeAttendanceStatus.absent: return Colors.red;
      case TakeAttendanceStatus.notMarked: return Colors.yellow.shade700;
    }
  }
}

//ATTENDANCE SUBMIT STATUS FOR TAKE ATTENDANCE
////on time , late, absent
enum AttendanceSubmitStatus{ onTime, absent, late }

extension AttendanceSubmitStatusExtension on AttendanceSubmitStatus {

  String get label {
    switch (this) {
      case AttendanceSubmitStatus.onTime:
        return "On Time";
      case AttendanceSubmitStatus.late:
        return "Late";
      case AttendanceSubmitStatus.absent:
        return "Absent";
    }
  }

  String get label2 {
    switch (this) {
      case AttendanceSubmitStatus.onTime:
        return "on time";
      case AttendanceSubmitStatus.late:
        return "late";
      case AttendanceSubmitStatus.absent:
        return "absent";
    }
  }
}


//CONTENT TYPE - CLASS, EXAM, HOMEWORK, ANNOUNCEMENT
enum AddContentType{ cClass, exam, homeWork, announcement }

extension AddContentTypeExtension on AddContentType {
  String get label {
    switch (this) {
      case AddContentType.cClass: return "Add Class";
      case AddContentType.exam: return "Add Exam";
      case AddContentType.homeWork: return "Add Homework";
      case AddContentType.announcement: return "Add Announcement";
    }
  }

  String get hint {
    switch (this) {
      case AddContentType.cClass: return "Enter class name";
      case AddContentType.exam: return "Enter exam name";
      case AddContentType.homeWork: return "Enter homework name";
      case AddContentType.announcement: return "Enter announcement title";
    }
  }
}

enum ContentDetailsType{ cClass, exam, homeWork }

extension ContentDetailsTypeExtension on ContentDetailsType {
  String get label {
    switch (this) {
      case ContentDetailsType.cClass: return "Class Details";
      case ContentDetailsType.exam: return "Exam";
      case ContentDetailsType.homeWork: return "Homework";
    }
  }
}

//HOMEWORK EXAM STATUS
enum TaskStatus{ active, timeOver }
extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.active:
        return "Active";
      case TaskStatus.timeOver:
        return "Time Over";
    }
  }

  String get label2 {
    switch (this) {
      case TaskStatus.active:
        return "active";
      case TaskStatus.timeOver:
        return "time over";
    }
  }

  Color get taskStatusColor {
    switch (this) {
      case TaskStatus.active:
        return Colors.green.shade500;
      case TaskStatus.timeOver:
        return Colors.yellow.shade900;
    }
  }
}

//Missing,Not Submitted,in time' , "Submitted on time" , "Late submitted
enum AnswerSubmissionStatus { missing, notSubmitted, inTime, submittedOnTime, lateSubmitted }

extension AnswerSubmissionStatusExtension on AnswerSubmissionStatus {
  String get label {
    switch (this) {
      case AnswerSubmissionStatus.missing:
        return "Missing";
      case AnswerSubmissionStatus.notSubmitted:
        return "Not Submitted";
      case AnswerSubmissionStatus.inTime:
        return "In Time";
      case AnswerSubmissionStatus.submittedOnTime:
        return "Submitted on Time";
        default:
        return "Late Submitted";
    }
  }

  String get label2 {
    switch (this) {
      case AnswerSubmissionStatus.missing:
        return "Missing";
      case AnswerSubmissionStatus.notSubmitted:
        return "Not Submitted";
      case AnswerSubmissionStatus.inTime:
        return "in time";
      case AnswerSubmissionStatus.submittedOnTime:
        return "Submitted on time";
      default:
        return "Late Submitted";
    }
  }

  Color get statusColor {
    switch (this) {
      case AnswerSubmissionStatus.missing:
        return Colors.orange;
      case AnswerSubmissionStatus.notSubmitted:
        return Colors.red.shade600;
        case AnswerSubmissionStatus.inTime:
        return Colors.green;
      case AnswerSubmissionStatus.submittedOnTime:
        return Colors.green;
      case AnswerSubmissionStatus.lateSubmitted:
        return Colors.yellow.shade700;
    }
  }
}