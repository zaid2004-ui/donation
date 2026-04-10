import 'package:cloud_firestore/cloud_firestore.dart';

class InstitutionsModel {
  final String name;
  final String image;
  final String donationNumber;
  final String categoryId;
  final String description;
  final String instituttionId;
  InstitutionsModel({
    required this.categoryId,
    required this.description,
    required this.instituttionId,
    required this.name,
    required this.image,
    required this.donationNumber,
  });
  factory InstitutionsModel.fromJson(Map<String, dynamic> json, String docId) {
    final categoryRef = json['category_ID'];
    String categoryId = '';
    if (categoryRef is DocumentReference) {
      categoryId = categoryRef.id;
    } else if (categoryRef is String) {
      categoryId = categoryRef.trim();
    }
    return InstitutionsModel(
      name: json['Name'] ?? '',
      image: json['Image_URL'] ?? '',
      donationNumber: json['Donation_Number'] ?? '',
      categoryId: categoryId,
      description: json['Description'] ?? '',
      instituttionId: json['Institutions_ID'] ?? docId,
    );
  }
}
