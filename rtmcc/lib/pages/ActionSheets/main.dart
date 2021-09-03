import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../core/MyPage/main.dart';
import '../../UI/Button/main.dart';
import '../../UI/ActionSheet/main.dart';

class ActionSheets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<ActionSheets> with MyPage {
  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: "操作表",
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              BlockButton(child: Text("弹出操作表"), onPressed: _onPress),
            ],
          ),
        ));
  }

  _operate1() {
    toast('您点击了操作1');
  }

  _operate2() {
    toast('您点击了操作2');
  }

  _operate3() {
    toast('您点击了操作3');
  }

  _onPress() {
    ActionSheet.of(context).show(
        items: ["操作1", "操作2", "操作3"],
        actions: [_operate1, _operate2, _operate3]);
  }
}
