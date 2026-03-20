import 'package:flutter/material.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/theme/app_icons.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.label});
  final String label;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  IconData statvisibility = AppIcons.visibilityOff;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,

      decoration: Generalwidget()
          .getInputDecoration(context, widget.label)
          .copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                  if (obscureText == true) {
                    statvisibility = AppIcons.visibilityOff;
                  } else {
                    statvisibility = AppIcons.visibility;
                  }
                });
              },
              icon: Icon(statvisibility),
            ),
          ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (value.length < 8 || value.length > 12) {
          return 'Password must be between 8 and 12 characters';
        }
        return null;
      },
    );
  }
}
