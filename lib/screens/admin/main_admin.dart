import 'package:flutter/material.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/core/router/route.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';

class MainAdmin extends StatelessWidget {
  const MainAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.admin_dashboard),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Icon(
                  Icons.admin_panel_settings,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(height: 12),

                Text(
                  AppLocalizations.of(context)!.welcome_admin,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 6),

                Text(
                  AppLocalizations.of(context)!.manage_app_here,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 40),

                GeneralWidget().getElevatedButton(
                  context,
                  AppLocalizations.of(context)!.add_category,
                  () {
                    Navigator.of(context).pushNamed(Routes.addCategoryPage);
                  },
                ),

                const SizedBox(height: 15),

                GeneralWidget().getElevatedButton(
                  context,
                  AppLocalizations.of(context)!.add_institution,
                  () {
                    Navigator.of(context).pushNamed(Routes.addInstitution);
                  },
                ),

                const SizedBox(height: 15),

                GeneralWidget().getElevatedButton(
                  context,
                  AppLocalizations.of(context)!.add_campaign,
                  () {
                    Navigator.of(context).pushNamed(Routes.addCampaign);
                  },
                ),

                const SizedBox(height: 15),

                GeneralWidget().getElevatedButton(context, "All Donations", () {
                  Navigator.of(context).pushNamed(Routes.allDonations);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
