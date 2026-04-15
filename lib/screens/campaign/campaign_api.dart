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
        .collection('Core Collections') // Collection الأب
        .doc('lWGLG8VymCuLNpfF3ovm') // الـ Document اللي جواته Categories
        .collection('Campaigns') // الـ Subcollection
        .where('Institution_ID', isEqualTo: institutionRef)
        .get();
    log('Found docs: ${response.docs.length}');
    log(institutionRef.path);

    return response.docs.map((doc) {
      return CampaaignModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
