// Function to show the donation bottom sheet
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasess/screens/Donation_process/donation_api.dart';
import 'package:plasess/screens/Donation_process/donation_model.dart';
import 'package:plasess/screens/campaign/campaign_model.dart';

void showDonateBottomSheet(BuildContext context, CampaaignModel campaign) {
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
      return StatefulBuilder(
        builder: (sheetContext, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  "Donate to ${campaign.title}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                SizedBox(height: 15),

                // Amount
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Amount"),
                ),

                SizedBox(height: 10),

                // Payment Method Dropdown
                DropdownButton<String>(
                  value: paymentMethod,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(value: "click", child: Text("Click")),
                    DropdownMenuItem(value: "card", child: Text("Card")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
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
                    decoration: InputDecoration(labelText: "Card Number"),
                  ),

                SizedBox(height: 20),

                // Donate Button
                ElevatedButton(
                  onPressed: () async {
                    final amount = double.tryParse(amountController.text);

                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter valid amount")),
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

                    await DonationApi().addDonation(
                      DonationModel(
                        compaignId: campaign.campaignId,
                        createdAT: DateTime.now(),
                        amount: amount,
                        institutionId: campaign.institutionId[0],
                        paymentMethod: paymentMethod,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        paymentDetails: paymentDetails,
                      ),
                    );
                    log("AMOUNT: $amount");
                    log("PAYMENT METHOD: $paymentMethod");
                    log("PAYMENT DETAILS: $paymentDetails");

                    log("After sending donation");
                    //because the bottom sheet is a different context
                    navigator.pop;
                    messenger.showSnackBar(
                      SnackBar(content: Text("Donation Successful")),
                    );
                  },
                  child: Text("Donate"),
                ),

                SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}
