import 'package:cloud_firestore/cloud_firestore.dart';

class CampaaignModel {
  final String campaignId;
  final String categoryId;
  final String institutionId;
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
    // References
    String parseRef(dynamic ref) {
      if (ref is DocumentReference) return ref.id;
      if (ref is String) return ref;
      return '';
    }

    // Timestamps
    DateTime parseDate(dynamic date) {
      if (date is Timestamp) return date.toDate();
      if (date is String) return DateTime.tryParse(date) ?? DateTime.now();
      return DateTime.now();
    }

    return CampaaignModel(
      campaignId: docID,
      // Category و Institution
      categoryId: parseRef(json['Category_ID']),
      institutionId: parseRef(json['Institution_ID']),

      title: json['Title'] ?? '',
      description: json['Description'] ?? '',
      imageUrl: json['Image_URL'] ?? '',

      //  timestamp
      createdAt: parseDate(json['Created_At']),
      startDate: parseDate(json['Start_Date']),
      endDate: parseDate(json['End_Date']),

      targetAmount: json['Target_Amount'] ?? 0,
      isActive: json['Is_Active'] ?? true,
    );
  }
}
