import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cache {
  static Future initialize() async {
    await Hive.initFlutter();
    await Hive.openBox('preferences');
  }

  static ValueListenable<Box> getPreferencesListenable() {
    return Hive.box('preferences').listenable();
  }

  static Future setDarkMode(bool value) async {
    await Hive.box('preferences').put('darkMode', value);
  }
}
