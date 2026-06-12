import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';

class CategoryApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CateogryModel>> getCategories() async {
    final resposn = await _firestore
        .collection('Core Collections') // Collection
        .doc('lWGLG8VymCuLNpfF3ovm') // Document ID
        .collection('Categories') // Subcollection
        .where('IS_Active', isEqualTo: true)
        .get();

    return resposn.docs.map((doc) {
      return CateogryModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<void> updateCategory(String id, String newName) async {
    await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Categories')
        .doc(id)
        .update({'Name': newName});
  }

  Future<void> deleteCategory(String id) async {
    await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Categories')
        .doc(id)
        .delete();
  }

  Future<String> addCategory(CateogryModel category) async {
    final docRef = _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Categories')
        .doc(); // id random
    await docRef.set({
      'CategoryId': docRef.id,
      'Name': category.name,
      'Image_URL': category.image,
      'IS_Active': category.isActeve,
      'Created_At': Timestamp.fromDate(category.createdAt),
      'nameAr': category.name,
      'nameEn': category.name,
    });

    return docRef.id;
  }
}
