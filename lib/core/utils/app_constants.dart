import 'dart:ui';

import 'package:flutter/material.dart';

import '../assets_gen/assets.gen.dart';
import 'app_strings.dart';

enum Role{
  teacher,
  assistant,
  student,
  parents
}

const String roleKey = "roleKey";

enum StudentStatus { onTrack, attention, behind, critical }

extension StatusColorExtension on StudentStatus {
  // Path to the SVG asset
  String get iconPath {
    switch (this) {
      case StudentStatus.onTrack: return Assets.icons.onTrack;
      case StudentStatus.attention: return Assets.icons.attention;
      case StudentStatus.behind: return Assets.icons.behind;
      case StudentStatus.critical: return Assets.icons.critical;
    }
  }

  // Main background color (light tint)
  Color get bgColor {
    switch (this) {
      case StudentStatus.onTrack: return const Color(0xFFF1FAF5);
      case StudentStatus.attention: return const Color(0xFFFFF9E6);
      case StudentStatus.behind: return const Color(0x26E68600);
      case StudentStatus.critical: return const Color(0x26F70004);
    }
  }

  // Border and Icon color
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

}


enum AttendanceStatus{ onTime, absent, late }

extension AttendanceStatusColorExtension on AttendanceStatus {

  String get label {
    switch (this) {
      case AttendanceStatus.onTime: return "On Time";
      case AttendanceStatus.late: return "Late";
      case AttendanceStatus.absent: return "Absent";
    }
  }

  Color get statusColor {
    switch (this) {
      case AttendanceStatus.onTime: return Colors.green;
      case AttendanceStatus.late: return Colors.orange;
      case AttendanceStatus.absent: return Colors.red;
    }
  }
}