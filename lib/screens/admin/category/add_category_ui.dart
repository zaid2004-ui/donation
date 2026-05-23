import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/screens/home/api_category/category_api.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final imageController = TextEditingController();
    final api = CategoryApi();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // NAME
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Category Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

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
                      imageController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill all fields")),
                    );
                    return;
                  }

                  final category = CateogryModel(
                    name: nameController.text,
                    image: imageController.text,
                    categoryId: "",
                    isActeve: true,
                    createdAt: DateTime.now(),
                  );

                  final id = await api.addCategory(category);
                  nameController.clear();
                  imageController.clear();
                  log('Category Added: $id');

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Category Added")),
                  );
                },
                child: const Text("Add Category"),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(Routes.addInstitution);
                },
                child: const Text("Add institution"),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(Routes.addCampaign);
                },
                child: const Text("Add Campaign"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
