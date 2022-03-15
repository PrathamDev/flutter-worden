import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static showCode(String code) {
    String msg = code.replaceAll("-", " ");
    Fluttertoast.showToast(msg: msg);
  }
}
