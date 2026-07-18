import 'package:dr_dina_educology/data/models/staff/staff_model.dart';

import '../../../core/utils/app_constants.dart';

class ProfileModel {
  final String? id;
  final List<StaffModel?> parents;
  final String firstName;
  final String lastName;
  final String fullName;
  final String image;
  final String email;
  final String contact;
  final String location;
  final String gender;
  final String about;
  final DateTime? dob;
  final UserStatus status;
  final Role role;
  final bool isOtpVerified;
  final bool isZoomConnected;

  ProfileModel({
    this.id,
    required this.parents,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.image,
    required this.email,
    required this.contact,
    required this.location,
    required this.gender,
    required this.about,
    this.dob,
    required this.status,
    required this.role,
    required this.isOtpVerified,
    required this.isZoomConnected
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {

    final rawParents = json['parentIds'] as List<dynamic>? ?? [];

    return ProfileModel(
      id: json['_id'] as String?,
        parents: rawParents
            .where((element) => element is Map<String, dynamic>)
            .map((item) => StaffModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] as String? ?? "",
      email: json['email'] ?? '',
      contact: json['contact'] ?? '',
      location: json['location'] ?? '',
        gender: json['gender'] ?? 'select',
        about: json['about'] ?? '',
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      status: UserStatus.fromString(json['status'] ?? ''),
      role: Role.fromString(json['role'] ?? ''),
      isOtpVerified: json['isOtpVerified'] ?? false,
        isZoomConnected: json['isZoomConnected'] ?? false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'parentIds': parents.map((parent) => parent?.toJson()).toList(),
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
      'isOtpVerified': isOtpVerified,
      'isZoomConnected': isZoomConnected,
      'about' : about,
      'gender' : gender
    };
  }
}