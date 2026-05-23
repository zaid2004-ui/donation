import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/institutions/institutions_model.dart';

class InstitutionsApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Get institutions by category ID
  Future<List<InstitutionsModel>> getIInstitutions(String categoryId) async {
    DocumentReference categoryRef = _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Categories')
        .doc(categoryId);

    final resposn = await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Institutions')
        .where('Category_ID', isEqualTo: categoryRef)
        .get();

    return resposn.docs.map((doc) {
      return InstitutionsModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<String> addInstitution(
    InstitutionsModel institution,
    String categoryId,
  ) async {
    DocumentReference categoryRef = _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Categories')
        .doc(categoryId);
    final docRef = _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Institutions')
        .doc();
    await docRef.set({
      'Name': institution.name,
      'Image_URL': institution.image,
      'Donation_Number': institution.donationNumber,
      'Description': institution.description,
      'Category_ID': categoryRef,
      'institutionId': docRef.id,
    });
    return docRef.id;
  }

  Future<void> updateInstitution(
    String id,
    String newName,
    String numberNew,
    String descriptionNew,
  ) async {
    await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Institutions')
        .doc(id)
        .update({
          'Name': newName,
          'Donation_Number': numberNew,
          'Description': descriptionNew,
        });
  }

  Future<void> deleteInstitution(String id) async {
    await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Institutions')
        .doc(id)
        .delete();
  }
}
