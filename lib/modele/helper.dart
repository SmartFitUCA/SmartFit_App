import 'package:flutter/foundation.dart';

class Helper {
  static bool isPlatformWeb() {
    if (kIsWeb) {
      return true;
    }
    return false;
  }
}
