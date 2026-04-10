import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/institutions/institutions_model.dart';

class InstitutionsApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<InstitutionsModel>> getIInstitutions(String categoryId) async {
    log('Querying Firestore for categoryId: $categoryId'); // تيست
    DocumentReference categoryRef = _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Categories')
        .doc(categoryId);

    final resposn = await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Institutions')
        .where('category_ID', isEqualTo: categoryRef)
        .get();

    return resposn.docs.map((doc) {
      return InstitutionsModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
