import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/profile/profile_model.dart';

class ProfilApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProfileModel>> getUserProfile(String userId) async {
    final resposn = await _firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('User')
        .where('User_ID', isEqualTo: userId)
        .get();

    return resposn.docs.map((doc) {
      return ProfileModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
