import 'package:cloud_firestore/cloud_firestore.dart';

class DonationModel {
  final double amount;

  /// References
  final DocumentReference campaignRef;
  final DocumentReference userRef;
  final DocumentReference institutionRef;

  final DateTime createdAt;

  final String paymentMethod;
  final Map<String, dynamic> paymentDetails;

  //denormalized for UI performance
  final String donorName;
  final String campaignTitle;
  final String message;

  DonationModel({
    required this.amount,
    required this.campaignRef,
    required this.userRef,
    required this.institutionRef,
    required this.createdAt,
    required this.paymentMethod,
    required this.paymentDetails,
    this.donorName = '',
    this.campaignTitle = '',
    this.message = '',
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      amount: (json['Amount'] ?? 0).toDouble(),

      campaignRef: json['Campaign_ID'] as DocumentReference,
      userRef: json['User_ID'] as DocumentReference,
      institutionRef: json['Institution_ID'] as DocumentReference,

      createdAt: (json['Created_At'] as Timestamp).toDate(),
      paymentMethod: json['Payment_Method'] ?? '',
      paymentDetails: Map<String, dynamic>.from(json['Payment_Details'] ?? {}),

      donorName: json['donorName'] ?? '',
      campaignTitle: json['campaignTitle'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Amount': amount,
      'Campaign_ID': campaignRef,
      'User_ID': userRef,
      'Institution_ID': institutionRef,
      'Date': Timestamp.fromDate(createdAt),
      'Payment_Method': paymentMethod,
      'Payment_Details': paymentDetails,

      'donorName': donorName,
      'campaignTitle': campaignTitle,
      'message': message,
    };
  }
}
