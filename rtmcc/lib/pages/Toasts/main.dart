import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/MyPage/main.dart';
import '../../UI/Button/main.dart';

class Toasts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Toasts> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "提示",
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            BlockButton(child: Text('一般短提示'), onPressed: _onPress),
            BlockButton(child: Text('滞留时间长一点的提示'), onPressed: _onPress1),
            BlockButton(child: Text('在中部显示'), onPressed: _onPress2),
            BlockButton(child: Text('在上方显示'), onPressed: _onPress3),
            BlockButton(child: Text('自定义位置显示'), onPressed: _onPress4),
            BlockButton(child: Text('自定义样式'), onPressed: _onPress5),
          ],
        ),
      ),
    );
  }

  void showToast(String info, [int? l]) {
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

  _onPress() {
    showToast("一般短提示");
  }

  _onPress1() {
    showToast("滞留时间长一点的提示", 5000);
  }

  _onPress2() {
    void showToast(String info, [int? l]) {
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
        gravity: ToastGravity.CENTER,
        toastDuration: Duration(milliseconds: L),
      );
    }

    showToast("在中部显示的提示");
  }

  _onPress3() {
    void showToast(String info, [int? l]) {
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
        gravity: ToastGravity.TOP,
        toastDuration: Duration(milliseconds: L),
      );
    }

    showToast("在上方显示的提示");
  }

  _onPress4() {
    void showToast(String info, [int? l]) {
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
          // gravity: ToastGravity.CENTER,
          toastDuration: Duration(milliseconds: L),
          positionedToastBuilder: (context, child) {
            return Positioned(
              child: child,
              top: 46.0,
              left: 16.0,
            );
          });
    }

    showToast("显示在坐标轴：top:46,left:16上");
  }

  _onPress5() {
    void showToast(String info, [int? l]) {
      // 默认显示2s
      int L = l ?? 2000;

      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text(info),
          ],
        ),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(milliseconds: L),
      );
    }

    showToast("自定义样式的提示");
  }
}
