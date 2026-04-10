import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';

class CategoryApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<CateogryModel>> getCategories() async {
    final resposn = await _firestore
        .collection('Core Collections') // Collection الأب
        .doc('lWGLG8VymCuLNpfF3ovm') // الـ Document اللي جواته Categories
        .collection('Categories') // الـ Subcollection
        .where('IS_Active', isEqualTo: true)
        .get();

    return resposn.docs.map((doc) {
      return CateogryModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
