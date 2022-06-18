import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../core/Util/main.dart';
import '../../core/MyPage/main.dart';

class ScanResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<ScanResult> with MyPage {
  String _result = "";

  @override
  void initState() {
    super.initState();
    init(context);

    Util.fixInit(() {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args is List) {
        setState(() {
          _result = args[0];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "扫描结果页",
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text("扫描结果：$_result"),
      ),
    );
  }
}
