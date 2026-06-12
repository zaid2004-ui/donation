import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/Donation_process/donation_model.dart';

class DonationApi {
  final CollectionReference donationsref = FirebaseFirestore.instance
      .collection('Supporting Collections') // collection
      .doc('YUvP7L7BrL4cCH6Wag7C') //   (Document ID)
      .collection('Donations'); // sub collection

  Future<void> addDonation(DonationModel donation) async {
    await donationsref.add({
      'Amount': donation.amount,
      'Campaign_ID': donation.campaignRef,
      'Created_At': Timestamp.fromDate(donation.createdAt),
      'Institution_ID': donation.institutionRef,
      'Payment_Method': donation.paymentMethod,
      'User_ID': donation.userRef,
      'Payment_Details': donation.paymentDetails,
      'donorName': donation.donorName,
      'campaignTitle': donation.campaignTitle,
      'message': donation.message,
    });
  }

  // all
  Future<List<DonationModel>> getAllDonations() async {
    final snapshot = await donationsref.get();

    return snapshot.docs.map((doc) {
      return DonationModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  //get donations of specific user
  Future<List<DonationModel>> getUserDonations(String userId) async {
    final userRef = FirebaseFirestore.instance
        .collection("Core Collections")
        .doc("lWGLG8VymCuLNpfF3ovm")
        .collection("User")
        .doc(userId);

    final snapshot = await donationsref
        .where('User_ID', isEqualTo: userRef)
        .get();

    return snapshot.docs
        .map((e) => DonationModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }
}
