class ProfileModel {
  final String name;
  final String email;
  final String userId;
  final String phoneNumber;
  ProfileModel({
    required this.name,
    required this.email,
    required this.userId,
    required this.phoneNumber,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json, String docID) {
    return ProfileModel(
      name: json['Name'] ?? '',
      email: json['Email'] ?? '',
      userId: docID,
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
}
