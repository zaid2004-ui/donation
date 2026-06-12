import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.add_category)),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // NAME
            GeneralWidget().getTextFormField(
              context,
              AppLocalizations.of(context)!.category_name,
              controller: nameController,
            ),
            // IMAGE URL
            const SizedBox(height: 15),
            GeneralWidget().getTextFormField(
              context,
              AppLocalizations.of(context)!.image_url,
              controller: imageController,
            ),

            const SizedBox(height: 25),

            GeneralWidget().getElevatedButton(
              context,
              AppLocalizations.of(context)!.add_category,
              () async {
                if (nameController.text.isEmpty ||
                    imageController.text.isEmpty) {
                  GeneralWidget().showErrorMessage(context, "Fill all fields");

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
                if (!context.mounted) {
                  return;
                }
                GeneralWidget().showSucessMessage(context, "Category Added");
              },
            ),
          ], // ADD BUTTON
        ),
      ),
    );
  }
}
