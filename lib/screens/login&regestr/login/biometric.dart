import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';

Future<void> getBiometric() async {
  // ···
  final LocalAuthentication auth = LocalAuthentication();
  // ···
  final bool canAuthenticateWithBiometrics = await auth.isDeviceSupported();
  if (!canAuthenticateWithBiometrics) {
    Fluttertoast.showToast(msg: "Device is not support biometrics");
  }
  final List<BiometricType> availableBiometrics = await auth
      .getAvailableBiometrics();

  if (availableBiometrics.isEmpty) {
    Fluttertoast.showToast(
      msg: "biometrics is empty pleas set up in devic setting ",
    );
  }

  try {
    final bool didAuthenticate = await auth.authenticate(
      localizedReason: 'Please authenticate to see private page contant',
    );
    if (didAuthenticate) {
      AppRouter.pushNamed(Routes.home);
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Something is wrong, please check the fields . ",
      backgroundColor: Colors.red,
    );
  }
}
