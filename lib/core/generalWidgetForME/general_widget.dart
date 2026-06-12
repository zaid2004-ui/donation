import 'package:flutter/material.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:wave_widget/wave_widget.dart';

class GeneralWidget {
  //ExpansionTile
  ExpansionTile getExpnsionTile(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return ExpansionTile(
      backgroundColor: Theme.of(context).colorScheme.surface,
      collapsedBackgroundColor: Theme.of(
        context,
      ).colorScheme.surface.withValues(alpha: 0.2),

      tilePadding: EdgeInsets.all(10),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  //CONTATER AND LISTTILE
  Widget getListTile(
    String title,
    String subtitle,
    Icon icon,
    Color color,
    BuildContext context,
    VoidCallback onTap,
  ) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        trailing: IconButton(onPressed: onTap, icon: icon),
      ),
    );
  }

  //wave widget for login and registe screens
  WavesWidget getWavesWidget(BuildContext context) {
    return WavesWidget(
      size: const Size(double.infinity, 250),
      waveLayers: [
        WaveLayer.solid(
          duration: 10000,
          heightFactor: 0.8,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ],
    );
  }

  //text field witout hiden
  TextFormField getTextFormField(
    BuildContext context,
    String label, {
    TextEditingController? controller,
  }) {
    return TextFormField(
      decoration: getInputDecoration(context, label),
      controller: controller,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.required_field;
        }
        if (!RegExp(r'^.+@.+\..+$').hasMatch(value)) {
          return AppLocalizations.of(context)!.invalid_email;
        }
        return null;
      },
    );
  }

  //text field password witout hiden
  TextFormField getTextFormFieldpassword(
    BuildContext context,
    String label, {
    TextEditingController? controller,
  }) {
    return TextFormField(
      decoration: getInputDecoration(context, label),
      controller: controller,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.required_field;
        }
        if (value.length < 8 || value.length > 12) {
          return AppLocalizations.of(context)!.password_length;
        }
        return null;
      },
    );
  }

  //getTextFormFieldpasswordconferm
  TextFormField getTextFormFieldpasswordconferm(
    BuildContext context,
    String label, {
    TextEditingController? controller,
    TextEditingController? passwordController,
  }) {
    return TextFormField(
      decoration: getInputDecoration(context, label),
      controller: controller,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.required_field;
        }
        if (passwordController == null || value != passwordController.text) {
          return AppLocalizations.of(context)!.password_match;
        }

        return null;
      },
    );
  }

  //getTextFormFieldUserNmae
  TextFormField getTextFormFieldUserNmae(
    BuildContext context,
    String label, {
    TextEditingController? controller,
  }) {
    return TextFormField(
      decoration: getInputDecoration(context, label),
      controller: controller,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.required_field;
        }

        return null;
      },
    );
  }

  //decoratoin text filed to inherate hiden filed
  InputDecoration getInputDecoration(BuildContext context, String label) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      labelText: label,
    );
  }

  // elvated button general
  Widget getElevatedButton(
    BuildContext context,
    String text,
    Function onPressed,
  ) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.8),
      ),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  // elvated button general
  Widget getElevatedButtonOnbording(
    BuildContext context,
    String text,
    Function onPressed,
  ) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.onPrimary.withValues(alpha: 0.8),
      ),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Widget getIconButton(BuildContext context, Icon icon, Function onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),

      child: IconButton(onPressed: () => onPressed(), icon: icon, iconSize: 40),
    );
  }

  //show sucss message
  void showSucessMessage(BuildContext context, String meesage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(meesage),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: Duration(seconds: 3),
      ),
    );
  }

  //show error message
  void showErrorMessage(BuildContext context, String meesage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(meesage),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
