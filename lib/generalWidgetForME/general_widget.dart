import 'package:flutter/material.dart';
import 'package:wave_widget/wave_widget.dart';

class Generalwidget {
  //ExpansionTile

  ExpansionTile getExpnsionTile(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return ExpansionTile(
      backgroundColor: Theme.of(context).colorScheme.surface,
      collapsedBackgroundColor: Theme.of(context).colorScheme.onPrimary,

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
  getListTile(
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
          color: Theme.of(context).colorScheme.surface,
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
          return 'This field is required';
        }
        if (!RegExp(r'^.+@.+\..+$').hasMatch(value)) {
          return "Enter a valid email";
        }
        return null;
      },
    );
  }

  //text field witout hiden
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
          return 'This field is required';
        }
        if (value.length < 8 || value.length > 12) {
          return 'password must be between 8 and 12 characters';
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
          return 'This field is required';
        }
        if (value != passwordController!.text) {
          return 'password and confirm password must be the same';
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
          return 'This field is required';
        }

        return null;
      },
    );
  }

  //decoratoin text filed to inherate hiden filed
  InputDecoration getInputDecoration(BuildContext context, String label) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(5),
      labelText: label,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
    );
  }

  // elvated button general
  ElevatedButton getElevatedButton(
    BuildContext context,
    String text,
    Function onPressed,
  ) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Container getIconButton(BuildContext context, Icon icon, Function onPressed) {
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
