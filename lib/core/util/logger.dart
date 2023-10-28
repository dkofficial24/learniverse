import 'package:flutter/foundation.dart';

class Log {
  static void i(dynamic msg, {String tag = 'LearniverseAppTag'}) {
    if (kDebugMode) {
      print('$tag $msg');
    }
  }
}
