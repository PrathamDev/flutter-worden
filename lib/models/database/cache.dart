import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cache {
  static Future initialize() async {
    await Hive.initFlutter();
    await Hive.openBox('preferences');
  }
}
