import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasess/screens/Donation_process/donation_model.dart';

class DonationApi {
  final CollectionReference donationsref = FirebaseFirestore.instance
      .collection('Supporting Collections') // collection
      .doc('YUvP7L7BrL4cCH6Wag7C') //   (Document ID)
      .collection('Donation'); // sub collection

  Future<void> addDonation(DonationModel donation) async {
    await donationsref.add({
      'Amount': donation.amount,
      'Campaign_ID': donation.compaignId,
      'Created_At': Timestamp.fromDate(donation.createdAT),
      'Institution_ID': donation.institutionId,
      'Payment_Method': donation.paymentMethod,
      'User_ID': donation.userId,
    });
  }
}
