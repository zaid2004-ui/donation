import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = ChangeNotifierProvider((ref) => StateLoclization());

class StateLoclization extends ChangeNotifier {
  var localNotefier = ValueNotifier<Locale>(Locale("en"));

  void swtchArb() {
    localNotefier.value = Locale("ar");
    notifyListeners();
  }

  void swatchEn() {
    localNotefier.value = Locale("en");
    notifyListeners();
  }
}
