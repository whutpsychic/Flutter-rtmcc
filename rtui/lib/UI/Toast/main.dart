import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

late FToast fToast;

class Toast {
  // 初始化
  static init(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
  }

  static void showToast(String info, [int? l]) {
    // 默认显示2s
    int L = l ?? 2000;

    Widget toast = Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[800],
      ),
      child: Text(
        "$info",
        style: TextStyle(color: Colors.white),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(milliseconds: L),
    );
  }

  static void hideToast() {
    fToast.removeCustomToast();
  }

  static void hideQueuedToast() {
    fToast.removeQueuedCustomToasts();
  }
}
