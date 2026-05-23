import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
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

  final institutionsApi = InstitutionsApi();
  List<InstitutionsModel> institutionsList = [];
  Future<void> getInstitutions(String categoryId) async {
    institutionsList = await institutionsApi.getIInstitutions(categoryId);
    for (var inst in institutionsList) {
      log(
        'Name: ${inst.name}, Donation: ${inst.donationNumber}, Category: ${inst.categoryId}',
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    log('Institutions page categoryId: ${widget.categoryId}'); // تيست
    getInstitutions(widget.categoryId);
    getRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('institutions')),
      body: ListView.builder(
        itemCount: institutionsList.length,
        itemBuilder: (context, index) => Card(
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  AppRouter.pushNamed(
                    Routes.campaign,
                    args: institutionsList[index],
                  );
                },
                child: ListTile(
                  isThreeLine: true,
                  horizontalTitleGap: 1,
                  //image
                  leading: Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  //title
                  title: Text(institutionsList[index].name),
                  //subtitle
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(institutionsList[index].description),
                      SizedBox(height: 5),
                      Text(' ${institutionsList[index].donationNumber}'),
                    ],
                  ),
                ),
              ),

              if (role == "Admin")
                // delete button for admin
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('update Institution'),

                            content: const Text(
                              'Are you sure you want to delete this category?',
                            ),

                            actions: [
                              TextButton(
                                onPressed: () {
                                  institutionsApi.updateInstitution(
                                    institutionsList[index].instituttionId,
                                    'new name',
                                    '100',
                                    'new description',
                                  );
                                },

                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

              // Edit button for admin
              Positioned(
                top: 5,
                left: 5,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.red),
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
                          title: const Text('Edit Institution'),

                          content: Column(
                            children: [
                              TextField(
                                controller: controllerName,

                                decoration: const InputDecoration(
                                  hintText: 'Enter new name',
                                ),
                              ),
                              TextField(
                                controller: controllerDescription,

                                decoration: const InputDecoration(
                                  hintText: 'Enter new description',
                                ),
                              ),
                              TextField(
                                controller: controllerDonationNumber,

                                decoration: const InputDecoration(
                                  hintText: 'Enter new donation number',
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

                                Navigator.pop(context);
                              },

                              child: const Text('Save'),
                            ),

                            // CANCEL
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
