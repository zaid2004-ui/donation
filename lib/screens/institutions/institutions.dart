import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasess/core/router/app_route.dart';
import 'package:plasess/core/router/route.dart';
import 'package:plasess/core/theme/app_icons.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/screens/institutions/institutions_api.dart';
import 'package:plasess/screens/institutions/institutions_model.dart';

class Institutions extends StatefulWidget {
  const Institutions(this.categoryId, {super.key});
  final String categoryId;

  @override
  State<Institutions> createState() => _InstitutionsState();
}

class _InstitutionsState extends State<Institutions> {
  String role = "User";
  // Admin actions for institution card
  Widget buildAdminActions(int index) {
    return Row(
      children: [
        // delete button for admin
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
                  title: Text(AppLocalizations.of(context)!.delete_institution),

                  content: Text(
                    AppLocalizations.of(context)!.delete_institution,
                  ),

                  actions: [
                    TextButton(
                      onPressed: () async {
                        await institutionsApi.deleteInstitution(
                          institutionsList[index].instituttionId,
                        );

                        if (!context.mounted) return;

                        Navigator.pop(context);

                        await getInstitutions(widget.categoryId);
                        setState(() {});
                      },

                      child: Text(
                        AppLocalizations.of(context)!.delete_institution,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        Spacer(),

        // Edit button for admin
        IconButton(
          icon: Icon(
            AppIcons.edit,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            final controllerName = TextEditingController(
              text: institutionsList[index].name,
            );
            final controllerDescription = TextEditingController(
              text: institutionsList[index].description,
            );
            final controllerDonationNumber = TextEditingController(
              text: institutionsList[index].donationNumber,
            );

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.update_institution),

                  content: Column(
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
                    ],
                  ),

                  actions: [
                    // SAVE
                    TextButton(
                      onPressed: () async {
                        await institutionsApi.updateInstitution(
                          institutionsList[index].instituttionId,
                          controllerName.text,
                          controllerDonationNumber.text,

                          controllerDescription.text,
                        );
                        if (!context.mounted) return;

                        Navigator.pop(context);
                      },

                      child: Text(AppLocalizations.of(context)!.save),
                    ),

                    // CANCEL
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

  // Get institutions by categoryId
  Future<void> getInstitutions(String categoryId) async {
    institutionsList = await institutionsApi.getIInstitutions(categoryId);
    for (var inst in institutionsList) {
      log(
        'Name: ${inst.name}, Donation: ${inst.donationNumber}, Category: ${inst.categoryId}',
      );
    }
    setState(() {});
  }

  final institutionsApi = InstitutionsApi();
  List<InstitutionsModel> institutionsList = [];

  @override
  void initState() {
    super.initState();
    log('Institutions page categoryId: ${widget.categoryId}'); // test
    getInstitutions(widget.categoryId);
    getRole();
  }

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.institutions)),

      body: ListView.builder(
        itemCount: institutionsList.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final item = institutionsList[index];

          return Card(
            elevation: 3,
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    AppRouter.pushNamed(Routes.campaign, args: item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/welcom1.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),

                            SizedBox(width: 12),

                            // CONTENT
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // NAME
                                  Text(
                                    isAr
                                        ? (item.nameAr ?? item.name)
                                        : (item.nameEn ?? item.name),

                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(height: 6),

                                  // DESCRIPTION
                                  Text(
                                    isAr
                                        ? (item.descriptionAr ??
                                              item.description)
                                        : (item.descriptionEn ??
                                              item.description),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                          fontSize: 13,
                                        ),
                                  ),

                                  SizedBox(height: 10),

                                  // DONATION CHIP
                                  Row(
                                    children: [
                                      Icon(
                                        AppIcons.volunteer,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withAlpha(26),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          "${item.donationNumber} Donations",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // ADMIN ACTIONS
                        if (role == "Admin") buildAdminActions(index),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
