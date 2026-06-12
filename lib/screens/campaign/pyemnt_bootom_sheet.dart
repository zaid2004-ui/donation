// Function to show the donation bottom sheet
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/screens/Donation_process/donation_api.dart';
import 'package:plasess/screens/Donation_process/donation_model.dart';
import 'package:plasess/screens/campaign/campaign_api.dart';
import 'package:plasess/screens/campaign/campaign_model.dart';

void showDonateBottomSheet(
  BuildContext context,
  CampaaignModel campaign,
  VoidCallback onDonationSuccess,
) {
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  final cardController = TextEditingController();

  String paymentMethod = "click";

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      final isAr = Localizations.localeOf(context).languageCode == 'ar';
      return StatefulBuilder(
        builder: (sheetContext, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    isAr
                        ? campaign.titleAr ?? campaign.title
                        : campaign.titleEn ?? campaign.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  SizedBox(height: 15),

                  // Payment Method Dropdown
                  DropdownButton<String>(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    value: paymentMethod,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: "click",
                        child: Text(
                          AppLocalizations.of(context)!.click,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "card",
                        child: Text(
                          AppLocalizations.of(context)!.card,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value!;
                      });
                    },
                  ),

                  SizedBox(height: 50),

                  // Amount
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Amount"),
                  ),

                  SizedBox(height: 10),

                  // Dynamic Fields
                  if (paymentMethod == "click")
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: "Phone Number"),
                    ),

                  if (paymentMethod == "card")
                    TextField(
                      controller: cardController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.card_number,
                      ),
                    ),

                  SizedBox(height: 20),

                  // Donate Button
                  ElevatedButton(
                    onPressed: () async {
                      final amount = double.tryParse(amountController.text);

                      if (amount == null || amount <= 0) {
                        GeneralWidget().showErrorMessage(
                          context,
                          AppLocalizations.of(context)!.enter_valid_amount,
                        );

                        return;
                      }

                      Map<String, dynamic> paymentDetails = {};

                      if (paymentMethod == "click") {
                        paymentDetails = {"phone": phoneController.text};
                      } else {
                        paymentDetails = {"cardNumber": cardController.text};
                      }

                      //TEST
                      log("Before sending donation");

                      final navigator = Navigator.of(sheetContext);
                      final messenger = ScaffoldMessenger.of(sheetContext);
                      // references
                      final user = FirebaseAuth.instance.currentUser!;
                      final firestore = FirebaseFirestore.instance;

                      // References
                      final userRef = FirebaseFirestore.instance
                          .collection("Core Collections")
                          .doc("lWGLG8VymCuLNpfF3ovm")
                          .collection("User")
                          .doc(user.uid);
                      log("User Ref: ${userRef.path}");
                      final campaignRef = firestore
                          .collection("Campaigns")
                          .doc(campaign.campaignId);

                      final institutionRef = firestore
                          .collection("Institutions")
                          .doc(campaign.institutionId[0]);

                      // 🔵 جلب اسم المستخدم (مرة واحدة فقط)
                      final userSnap = await userRef.get();
                      final donorName = userSnap.data()?['Name'] ?? '';

                      await DonationApi().addDonation(
                        DonationModel(
                          campaignRef: campaignRef,
                          amount: amount,
                          institutionRef: institutionRef,
                          paymentMethod: paymentMethod,
                          userRef: userRef,
                          paymentDetails: paymentDetails,
                          createdAt: DateTime.now(),
                          donorName: donorName,
                          campaignTitle: campaign.title,
                          message: '',
                        ),
                      );

                      //  ++  count

                      await FirebaseFirestore.instance
                          .collection('Core Collections')
                          .doc('lWGLG8VymCuLNpfF3ovm')
                          .collection('Campaigns')
                          .doc(campaign.campaignId) // 👈 مهم جدًا
                          .update({"donorCount": FieldValue.increment(1)});

                      log("AMOUNT: $amount");
                      log("PAYMENT METHOD: $paymentMethod");
                      log("PAYMENT DETAILS: $paymentDetails");

                      log("After sending donation");
                      //because the bottom sheet is a different context
                      navigator.pop();
                      //clean controler
                      amountController.clear();
                      phoneController.clear();
                      cardController.clear();
                      // GeneralWidget().showSucessMessage(
                      //   context,
                      //   AppLocalizations.of(context)!.donation_successful,
                      // );

                      await CampaignApi().donatedToCampaign(
                        campaign.campaignId,
                        amount,
                      );
                      onDonationSuccess();

                      if (!context.mounted) return;

                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context)!.donation_successful,
                          ),
                        ),
                      );
                    },

                    child: Text(AppLocalizations.of(context)!.donate),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
