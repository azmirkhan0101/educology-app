class StaffModel {
  String id;
  String fullName;
  String image;
  String email;
  String contact;

  StaffModel({
    required this.id,
    required this.fullName,
    required this.image,
    required this.email,
    required this.contact
  });

  factory StaffModel.fromJson(Map<String, dynamic>? json) {

    if( json == null ){
      return StaffModel(
          id: "",
          fullName: "",
          image: "",
          email: "",
          contact: ""
      );
    }

    return StaffModel(
      id: json['_id'] ?? "",
      fullName: json['fullName'] ?? "",
      image: json['image'] ?? "",
      email: json['email'] ?? "",
      contact: json['contact'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'image': image,
      'email': email,
      'contact': contact
    };
  }
}