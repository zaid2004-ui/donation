import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/screens/home/api_category/category_api.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';
import 'package:plasess/screens/institutions/institutions_model.dart';

class AddCampaignPage extends StatefulWidget {
  const AddCampaignPage({super.key});

  @override
  State<AddCampaignPage> createState() => _AddCampaignPageState();
}

class _AddCampaignPageState extends State<AddCampaignPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();
  final targetController = TextEditingController();

  String? selectedCategoryId;
  List<String> selectedInstitutionIds = [];

  List<CateogryModel> categories = [];
  List<InstitutionsModel> institutions = [];

  DateTime? startDate;
  DateTime? endDate;

  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    categories = await CategoryApi().getCategories();

    final res = await firestore
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('Institutions')
        .get();

    institutions = res.docs
        .map((doc) => InstitutionsModel.fromJson(doc.data(), doc.id))
        .toList();

    setState(() {});
  }

  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.add_campaign)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TITLE
            GeneralWidget().getTextFormField(
              context,
              "Title",
              controller: titleController,
            ),

            const SizedBox(height: 10),
            // DESCRIPTION
            GeneralWidget().getTextFormField(
              context,
              "Description",
              controller: descriptionController,
            ),

            const SizedBox(height: 10),

            // IMAGE URL
            GeneralWidget().getTextFormField(
              context,
              "Image URL",
              controller: imageController,
            ),

            const SizedBox(height: 10),
            // TARGET AMOUNT
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Target Amount"),
            ),
            const SizedBox(height: 10),

            /// CATEGORY
            DropdownButtonFormField<String>(
              initialValue: selectedCategoryId,
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat.categoryId,
                  child: Text(cat.name),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedCategoryId = val),
              decoration: const InputDecoration(labelText: "Category"),
            ),

            const SizedBox(height: 15),

            ///  MULTI SELECT INSTITUTIONS
            Column(
              children: institutions.map((inst) {
                return CheckboxListTile(
                  title: Text(inst.name),
                  value: selectedInstitutionIds.contains(inst.instituttionId),
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        selectedInstitutionIds.add(inst.instituttionId);
                      } else {
                        selectedInstitutionIds.remove(inst.instituttionId);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 15),

            /// DATES
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => pickDate(true),
                    child: Text(
                      startDate == null ? "Start Date" : startDate.toString(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => pickDate(false),
                    child: Text(
                      endDate == null ? "End Date" : endDate.toString(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ADD CAMPAIGN BUTTON
            GeneralWidget().getElevatedButton(
              context,
              "Add Campaign",
              () async {
                if (selectedCategoryId == null ||
                    selectedInstitutionIds.isEmpty ||
                    startDate == null ||
                    endDate == null) {
                  GeneralWidget().showErrorMessage(context, "Fill all fields");

                  return;
                }
                // Validate dates
                if (endDate!.isBefore(startDate!)) {
                  GeneralWidget().showErrorMessage(
                    context,
                    "End date cannot be before start date",
                  );
                  return;
                }

                if (endDate!.isAtSameMomentAs(startDate!)) {
                  GeneralWidget().showErrorMessage(
                    context,
                    "End date must be after start date",
                  );
                  return;
                }

                // Convert institution IDs to DocumentReferences
                List<DocumentReference> institutionRefs = selectedInstitutionIds
                    .map((id) {
                      return firestore
                          .collection('Core Collections')
                          .doc('lWGLG8VymCuLNpfF3ovm')
                          .collection('Institutions')
                          .doc(id);
                    })
                    .toList();

                DocumentReference categoryRef = firestore
                    .collection('Core Collections')
                    .doc('lWGLG8VymCuLNpfF3ovm')
                    .collection('Categories')
                    .doc(selectedCategoryId);

                await firestore
                    .collection('Core Collections')
                    .doc('lWGLG8VymCuLNpfF3ovm')
                    .collection('Campaigns')
                    .add({
                      'Title': titleController.text,
                      'Description': descriptionController.text,
                      'Image_URL': imageController.text,
                      'Target_Amount': double.parse(targetController.text),
                      'Category_ID': categoryRef,
                      'Institution_IDs': institutionRefs,
                      'Start_Date': startDate,
                      'End_Date': endDate,
                      'Created_At': DateTime.now(),
                      'Is_Active': true,
                    });

                if (!context.mounted) return;
                GeneralWidget().showSucessMessage(context, "Campaign Added");
              },
            ),
          ],
        ),
      ),
    );
  }
}
