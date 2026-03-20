import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateTheme = ChangeNotifierProvider((ref) => SwitchTheme());

class SwitchTheme extends ChangeNotifier {
  bool isDark = false;
  void lighh() {
    isDark = false;
    notifyListeners();
  }

  void darkk() {
    isDark = true;
    notifyListeners();
  }
}
