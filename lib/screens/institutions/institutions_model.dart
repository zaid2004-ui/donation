import 'package:cloud_firestore/cloud_firestore.dart';

class InstitutionsModel {
  final String name;
  final String? nameAr;
  final String? nameEn;

  final String image;
  final String donationNumber;
  final String categoryId;
  final String description;
  final String? descriptionAr;
  final String? descriptionEn;

  final String instituttionId;

  InstitutionsModel({
    required this.categoryId,
    required this.description,
    this.descriptionAr,
    this.descriptionEn,
    required this.instituttionId,
    required this.name,
    this.nameAr,
    this.nameEn,
    required this.image,
    required this.donationNumber,
  });

  factory InstitutionsModel.fromJson(Map<String, dynamic> json, String docId) {
    final categoryRef = json['Category_ID'];

    String categoryId = '';
    if (categoryRef is DocumentReference) {
      categoryId = categoryRef.id;
    } else if (categoryRef is String) {
      categoryId = categoryRef.trim();
    }

    return InstitutionsModel(
      name: json['Name'] ?? '',
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],

      image: json['Image_URL'] ?? '',
      donationNumber: json['Donation_Number'] ?? '',

      categoryId: categoryId,

      description: json['Description'] ?? '',
      descriptionAr: json['descriptionAr'],
      descriptionEn: json['descriptionEn'],

      instituttionId: docId,
    );
  }
}
