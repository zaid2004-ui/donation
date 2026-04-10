import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plasess/screens/institutions/institutions_api.dart';
import 'package:plasess/screens/institutions/institutions_model.dart';

class Institutions extends StatefulWidget {
  const Institutions(this.categoryId, {super.key});
  final String categoryId;

  @override
  State<Institutions> createState() => _InstitutionsState();
}

class _InstitutionsState extends State<Institutions> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('institutions')),
      body: ListView.builder(
        itemCount: institutionsList.length,
        itemBuilder: (context, index) => Card(
          color: Theme.of(context).colorScheme.surface,
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
                Text('📞 ${institutionsList[index].donationNumber}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
