import 'package:cloud_firestore/cloud_firestore.dart';

class DonationModel {
  final double amount;
  final String compaignId;
  final DateTime createdAT;
  final String institutionId;
  final String paymentMethod;
  final String userId;
  final Map<String, dynamic> paymentDetails;

  DonationModel({
    required this.amount,
    required this.compaignId,
    required this.createdAT,
    required this.institutionId,
    required this.paymentMethod,
    required this.userId,
    required this.paymentDetails,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json, String docId) {
    return DonationModel(
      // donationId: docId, // Uncomment if you have a donationId field
      amount: (json['Amount'] ?? 0).toDouble(),

      compaignId: json['Campaign_ID'] as String,

      createdAT: (json['Created_At'] as Timestamp).toDate(),

      institutionId: json['Institution_ID'] as String,

      paymentMethod: json['Payment_Method'] ?? '',

      userId: json['User_ID'] as String,

      paymentDetails: Map<String, dynamic>.from(json['Payment_Details'] ?? {}),
    );
  }
}
