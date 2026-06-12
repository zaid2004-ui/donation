import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/screens/home/api_category/category_api.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';

import 'package:plasess/screens/institutions/institutions_api.dart';
import 'package:plasess/screens/institutions/institutions_model.dart';

class AddInstitution extends StatefulWidget {
  const AddInstitution({super.key});

  @override
  State<AddInstitution> createState() => _AddInstitutionState();
}

class _AddInstitutionState extends State<AddInstitution> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final api = InstitutionsApi();
  String? selectedCategoryId;

  List<CateogryModel> categories = [];

  Future<void> loadCategories() async {
    final categoryApi = CategoryApi();
    categories = await categoryApi.getCategories();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.add_institution),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // NAME
              GeneralWidget().getTextFormField(
                context,
                "Institution Name",
                controller: nameController,
              ),
              const SizedBox(height: 15),

              //dropdown for category selection
              DropdownButtonFormField<String>(
                initialValue: selectedCategoryId,
                decoration: const InputDecoration(
                  labelText: "Select Category",
                  border: OutlineInputBorder(),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.categoryId,
                    child: Text(category.name),
                  );
                }).toList(),

                onChanged: (String? value) {
                  setState(() {
                    selectedCategoryId = value;
                  });
                },
              ),

              const SizedBox(height: 15),
              // DESCRIPTION
              GeneralWidget().getTextFormField(
                context,
                "Description",
                controller: descriptionController,
              ),

              const SizedBox(height: 15),

              // PHONE NUMBER
              IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                initialCountryCode: 'JO',
                onChanged: (phone) {
                  log(phone.completeNumber);
                },
              ),

              const SizedBox(height: 10),

              GeneralWidget().getTextFormField(
                context,
                AppLocalizations.of(context)!.image_url,
                controller: imageController,
              ),

              const SizedBox(height: 25),

              // ADD BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        imageController.text.isEmpty) {
                      GeneralWidget().showErrorMessage(
                        context,
                        "Fill all fields",
                      );

                      return;
                    }

                    final institution = InstitutionsModel(
                      categoryId: selectedCategoryId!,
                      name: nameController.text,
                      image: imageController.text,
                      description: descriptionController.text,
                      donationNumber: phoneController.text,
                      instituttionId: '',
                    );

                    final id = await api.addInstitution(
                      institution,
                      selectedCategoryId!,
                    );

                    nameController.clear();
                    imageController.clear();
                    descriptionController.clear();
                    phoneController.clear();
                    log('Institution Added: $id');
                    if (!context.mounted) {
                      return;
                    }
                    // show success message
                    GeneralWidget().showSucessMessage(
                      context,
                      "Institution Added",
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.add_institution),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
