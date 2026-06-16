import 'package:cloud_firestore/cloud_firestore.dart';

class DonationModel {
  final double amount;

  /// References - تم جعلها اختيارية (nullable) لتجنب انهيار الكود
  final DocumentReference? campaignRef;
  final DocumentReference? userRef;
  final DocumentReference? institutionRef;

  final DateTime createdAt;
  final String paymentMethod;
  final Map<String, dynamic> paymentDetails;
  final String donorName;
  final String campaignTitle;
  final String message;

  DonationModel({
    required this.amount,
    this.campaignRef,
    this.userRef,
    this.institutionRef,
    required this.createdAt,
    required this.paymentMethod,
    required this.paymentDetails,
    this.donorName = '',
    this.campaignTitle = '',
    this.message = '',
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      // معالجة المبلغ لضمان عدم حدوث خطأ إذا كان int أو double
      amount: (json['Amount'] is num)
          ? (json['Amount'] as num).toDouble()
          : 0.0,

      // استخدام فحص النوع لتجنب خطأ التوافق
      campaignRef: json['Campaign_ID'] is DocumentReference
          ? json['Campaign_ID'] as DocumentReference
          : null,
      userRef: json['User_ID'] is DocumentReference
          ? json['User_ID'] as DocumentReference
          : null,
      institutionRef: json['Institution_ID'] is DocumentReference
          ? json['Institution_ID'] as DocumentReference
          : null,

      // معالجة التاريخ بوجود null أو أنواع بيانات أخرى
      createdAt: (json['Created_At'] is Timestamp)
          ? (json['Created_At'] as Timestamp).toDate()
          : DateTime.now(),

      paymentMethod: (json['Payment_Method'] as String?) ?? '',

      // معالجة الـ Map بشكل آمن
      paymentDetails: (json['Payment_Details'] is Map)
          ? Map<String, dynamic>.from(json['Payment_Details'] as Map)
          : {},

      donorName: (json['donorName'] as String?) ?? '',
      campaignTitle: (json['campaignTitle'] as String?) ?? '',
      message: (json['message'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Amount': amount,
      'Campaign_ID': campaignRef,
      'User_ID': userRef,
      'Institution_ID': institutionRef,
      'Created_At': Timestamp.fromDate(createdAt),
      'Payment_Method': paymentMethod,
      'Payment_Details': paymentDetails,
      'donorName': donorName,
      'campaignTitle': campaignTitle,
      'message': message,
    };
  }
}
