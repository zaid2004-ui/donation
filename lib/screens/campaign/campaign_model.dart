import 'package:cloud_firestore/cloud_firestore.dart';

class CampaaignModel {
  final String campaignId;
  final String categoryId;
  final List<String> institutionId;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final double targetAmount;
  final bool isActive;

  CampaaignModel({
    required this.campaignId,
    required this.categoryId,
    required this.institutionId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.targetAmount,
    required this.isActive,
  });

  factory CampaaignModel.fromJson(Map<String, dynamic> json, String docID) {
    return CampaaignModel(
      campaignId: docID,

      categoryId: json['Category_ID'] is DocumentReference
          ? (json['Category_ID'] as DocumentReference).id
          : (json['Category_ID'] ?? ''),

      institutionId: (json['Institution_IDs'] as List? ?? [])
          .map((item) => item is DocumentReference ? item.id : item.toString())
          .toList(),

      title: json['Title'] ?? '',
      description: json['Description'] ?? '',
      imageUrl: json['Image_URL'] ?? '',

      createdAt: (json['Created_At'] as Timestamp? ?? Timestamp.now()).toDate(),
      startDate: (json['Start_Date'] as Timestamp? ?? Timestamp.now()).toDate(),
      endDate: (json['End_Date'] as Timestamp? ?? Timestamp.now()).toDate(),

      targetAmount: (json['Target_Amount'] ?? 0).toDouble(),
      isActive: json['Is_Active'] ?? true,
    );
  }
}
