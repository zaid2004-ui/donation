import 'dart:developer';

import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text("Add Institution")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // NAME
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Institution Name",
                border: OutlineInputBorder(),
              ),
            ),
            //dropdown for category selection
            DropdownButtonFormField<String>(
              value: selectedCategoryId,
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
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // PHONE NUMBER
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            // IMAGE URL
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: "Image URL",
                border: OutlineInputBorder(),
              ),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill all fields")),
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

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Institution Added")),
                  );
                },
                child: const Text("Add Institution"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
