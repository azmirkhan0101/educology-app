import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

import '../../../core/utils/app_constants.dart';

class ProfileModel {
  final String? id;
  final StaffModel? parent;
  final String firstName;
  final String lastName;
  final String fullName;
  final String image;
  final String email;
  final String contact;
  final String location;
  final DateTime? dob;
  final UserStatus status;
  final Role role;
  final bool isOtpVerified;

  ProfileModel({
    this.id,
    this.parent,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.image,
    required this.email,
    required this.contact,
    required this.location,
    this.dob,
    required this.status,
    required this.role,
    required this.isOtpVerified
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] as String?,
        parent: json['parentId'] != null ? StaffModel.fromJson(json['parentId']) : null,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] as String? ?? "",
      email: json['email'] ?? '',
      contact: json['contact'] ?? '',
      location: json['location'] ?? '',
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      status: UserStatus.fromString(json['status'] ?? ''),
      role: Role.fromString(json['role'] ?? ''),
      isOtpVerified: json['isOtpVerified'] ?? false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'parentId': parent?.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'image': image,
      'email': email,
      'contact': contact,
      'location': location,
      'dob': dob?.toIso8601String(),
      'status': status.toJson(),
      'role': role.toJson(),
      'isOtpVerified': isOtpVerified
    };
  }
}