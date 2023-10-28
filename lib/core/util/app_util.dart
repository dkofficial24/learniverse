import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static void showToast({
    required String msg,
  }) {
    Fluttertoast.showToast(msg: msg);
  }
}
