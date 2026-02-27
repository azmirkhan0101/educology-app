class ProfileModel {

  final String image;
  final String firstName;
  final String lastName;
  final String email;
  final String contact;
  final String location;
  final DateTime dob;
  final int point;
  final String loyalityTier;

  ProfileModel({
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.location,
    required this.dob,
    required this.point,
    required this.loyalityTier
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        image: json['image'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      contact: json['contact'] ?? "",
      location: json['location'] ?? "",
      dob: DateTime.parse(json['dob'] as String),
      point: json['point'] ?? 0,
      loyalityTier: json['loyalityTier'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contact': contact,
      'location': location,
      'dob': dob.toIso8601String(),
      'point': point,
      'loyalityTier': loyalityTier
    };
  }




}