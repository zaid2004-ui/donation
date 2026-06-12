import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/core/theme/app_icons.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/screens/campaign/campaign_api.dart';
import 'package:plasess/screens/campaign/campaign_model.dart';
import 'package:plasess/screens/campaign/pyemnt_bootom_sheet.dart';

class Campain extends StatefulWidget {
  const Campain({
    super.key,
    required this.name,
    required this.description,
    required this.donationNumber,
    required this.instatiosnId,
    required this.imageUrl,
    this.descriptionAr,
    this.descriptionEn,
    this.nameAr,
    this.nameEn,
  });
  final String name;
  final String description;
  final String donationNumber;
  final String instatiosnId;
  final String imageUrl;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? nameAr;
  final String? nameEn;

  @override
  State<Campain> createState() => _CampainState();
}

class _CampainState extends State<Campain> {
  bool campaignStatus = true;
  // build admin actions
  Widget buildAdminActions(int index) {
    return Row(
      children: [
        //delete
        IconButton(
          icon: Icon(
            AppIcons.delete,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.delete_campaign),
                  content: Text(
                    AppLocalizations.of(context)!.confirm_delete_campaign,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await campaignApi.deleteCampaign(
                          campaignsList[index].campaignId,
                        );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        getCampaigns(widget.instatiosnId);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.delete_campaigns,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),

        const Spacer(),

        //edit
        IconButton(
          icon: Icon(
            AppIcons.edit,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            final controllerName = TextEditingController(
              text: campaignsList[index].title,
            );
            final controllerDescription = TextEditingController(
              text: campaignsList[index].description,
            );
            final controllerDonationNumber = TextEditingController(
              text: campaignsList[index].targetAmount.toString(),
            );
            String campaignStatus = campaignsList[index].isActive
                ? "Active"
                : "Inactive";

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.edit_campaign),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controllerName,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_new_name,
                          ),
                        ),
                        TextField(
                          controller: controllerDescription,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_new_description,
                          ),
                        ),
                        TextField(
                          controller: controllerDonationNumber,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_new_donation_number,
                          ),
                        ),

                        // Payment Method Dropdown
                        DropdownButton<String>(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          value: campaignStatus,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                              value: "Active",
                              child: Text(
                                AppLocalizations.of(context)!.active,
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Inactive",
                              child: Text(
                                AppLocalizations.of(context)!.inactive,
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              campaignStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await campaignApi.updateCampaign(
                          campaignsList[index].campaignId,
                          controllerName.text,
                          double.parse(controllerDonationNumber.text),
                          controllerDescription.text,
                          campaignStatus == "Active",
                        );

                        getCampaigns(widget.instatiosnId);
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.save),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  String role = "";
  // Get user role from Firestore
  Future<void> getRole() async {
    final user = FirebaseAuth.instance.currentUser!;
    final doc = await FirebaseFirestore.instance
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('User')
        .doc(user.uid)
        .get();
    setState(() {
      role = doc.data()!['Role'];
    });
    log("User Role: $role");
  }

  // controler
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cardNumberContrller = TextEditingController();
  TextEditingController cardHolderNberContrller = TextEditingController();
  //dispose
  @override
  void dispose() {
    amountController.dispose();
    phoneController.dispose();
    cardNumberContrller.dispose();
    cardHolderNberContrller.dispose();
    super.dispose();
  }

  final campaignApi = CampaignApi();
  List<CampaaignModel> campaignsList = [];
  //getcampaigns
  Future<void> getCampaigns(String instatiosnId) async {
    campaignsList = await campaignApi.getCampaigns(instatiosnId);
    setState(() {});
    log(
      'Fetched ${campaignsList.length} campaigns for instatiosnId: $instatiosnId',
    );
  }

  // initstate
  @override
  void initState() {
    getRole();
    getCampaigns(widget.instatiosnId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isAr = AppLocalizations.of(context)!.localeName == 'ar';
    return Scaffold(
      appBar: AppBar(
        title: isAr
            ? Text(widget.nameAr ?? widget.name)
            : Text(widget.nameEn ?? widget.name),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),

            //decoration
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.imageUrl,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/welcom1.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                //description
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      textAlign: TextAlign.center,
                      isAr
                          ? (widget.descriptionAr ?? widget.description)
                          : (widget.descriptionEn ?? widget.description),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(fontSize: 18),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                //Donation Number
                Text(
                  'Donation Number: ${widget.donationNumber}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          ...List.generate(campaignsList.length, (index) {
            //data progrese par
            final coloected = campaignsList[index].collectedAmount;
            final targetAmount = campaignsList[index].targetAmount;
            log('++++++++++++++++${coloected.toString()}'); //test
            log(targetAmount.toString()); //test
            final progres = (coloected / targetAmount).clamp(0.0, 1.0);

            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    if (!campaignsList[index].isActive) {
                      GeneralWidget().showErrorMessage(
                        context,
                        'Campaign is completed',
                      );
                      return;
                    }
                    showDonateBottomSheet(
                      context,
                      campaignsList[index],
                      () async {
                        await getCampaigns(widget.instatiosnId);
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 6,
                      //rounde rectangel
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TITLE
                            Center(
                              child: Text(
                                isAr
                                    ? (campaignsList[index].titleAr ??
                                          campaignsList[index].title)
                                    : (campaignsList[index].titleEn ??
                                          campaignsList[index].title),

                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                campaignsList[index].imageUrl,
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  width: double.infinity,
                                  height: 160,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // DESCRIPTION
                            Text(
                              textAlign: TextAlign.center,
                              isAr
                                  ? (campaignsList[index].descriptionAr ??
                                        campaignsList[index].description)
                                  : (campaignsList[index].descriptionEn ??
                                        campaignsList[index].description),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // INFO
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Donation Number: ${campaignsList[index].donorCount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Target Amount: ${campaignsList[index].targetAmount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Start: ${campaignsList[index].startDate.toString().split(' ')[0]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                  ),
                                  Text(
                                    "End: ${campaignsList[index].endDate.toString().split(' ')[0]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // STATUS
                            Row(
                              children: [
                                Text(
                                  "Status: ",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: campaignsList[index].isActive
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.primary.withAlpha(2)
                                        : Theme.of(
                                            context,
                                          ).colorScheme.error.withAlpha(2),

                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    campaignsList[index].isActive
                                        ? "Active"
                                        : "Inactive",
                                    style: TextStyle(
                                      color: campaignsList[index].isActive
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Theme.of(context).colorScheme.error,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //progress indecator
                            LinearProgressIndicator(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              value: progres.clamp(0.0, 1.0),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.onSurface,
                              color: Theme.of(context).colorScheme.primary,
                              minHeight: 8,
                            ),
                            if (role == "Admin") buildAdminActions(index),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
