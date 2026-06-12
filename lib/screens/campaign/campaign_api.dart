import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/campaign/campaign_model.dart';

class CampaignApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<CampaaignModel>> getCampaigns(String institutionId) async {
    //  final categoryRef = _firestore
    //     .collection('Core Collections')
    //     .doc('lWGLG8VymCuLNpfF3ovm')
    //     .collection('Categories')
    //     .doc(institutionId);
    final institutionRef = _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Institutions')
        .doc(institutionId.trim());
    final response = await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Campaigns')
        .where('Institution_IDs', arrayContains: institutionRef)
        .get();
    log('Found docs: ${response.docs.length}');
    log(institutionRef.path);

    return response.docs.map((doc) {
      return CampaaignModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<void> addCampaign(CampaaignModel campaign) async {
    final firestore = FirebaseFirestore.instance;

    /// 🔹 category reference
    DocumentReference categoryRef = firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Categories')
        .doc(campaign.categoryId);

    /// 🔹 institutions references
    List<DocumentReference> institutionRefs = campaign.institutionId.map((id) {
      return firestore
          .collection('Core Collections')
          .doc('lWGLG8VymCuLNpfF3ovm')
          .collection('Institutions')
          .doc(id);
    }).toList();

    /// 🔹 create doc with auto ID
    final docRef = firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Campaigns')
        .doc();

    await docRef.set({
      'Campaign_ID': docRef.id,
      'Title': campaign.title,
      'Description': campaign.description,
      'Image_URL': campaign.imageUrl,
      'Target_Amount': campaign.targetAmount,
      'Category_ID': categoryRef,
      'Institution_IDs': institutionRefs,
      'Start_Date': campaign.startDate,
      'End_Date': campaign.endDate,
      'Created_At': campaign.createdAt,
      'Is_Active': campaign.isActive,
      'Collected_Amount': campaign.collectedAmount,
      'donorCount': campaign.donorCount,
      'titleAr': '',
      'titleEn': '',
      'descriptionAr': '',
      'descriptionEn': '',
    });
  }

  Future<void> updateCampaign(
    String id,
    String newName,
    double numberNew,
    String descriptionNew,
    bool isActive,
  ) async {
    await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Campaigns')
        .doc(id)
        .update({
          'Title': newName,
          'Target_Amount': numberNew,
          'Description': descriptionNew,
          'Is_Active': isActive,
        });
  }

  Future<void> deleteCampaign(String id) async {
    await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Campaigns')
        .doc(id)
        .delete();
  }

  Future<void> donatedToCampaign(
    String campaignId,
    double donationAmount,
  ) async {
    /// 🔹 create doc with auto ID
    final docRef = _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Campaigns')
        .doc(campaignId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      double target = ((snapshot.data()?['Target_Amount'] ?? 0) as num)
          .toDouble();
      double colected = ((snapshot.data()?['Collected_Amount'] ?? 0) as num)
          .toDouble();
      double newCollected = colected + donationAmount;
      bool isCompleted = newCollected >= target;
      transaction.update(docRef, {
        'Collected_Amount': newCollected,
        'Is_Active': !isCompleted,
      });
    });
  }
}
