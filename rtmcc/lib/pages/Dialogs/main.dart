import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter/cupertino.dart';
import '../../core/MyPage/main.dart';
import '../../UI/Button/main.dart';
import '../../UI/Dialog/main.dart';

class Dialogs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Dialogs> with MyPage {
  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "对话框",
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            BlockButton(
                filled: true, child: Text("警告对话框"), onPressed: _onPress),
            BlockButton(
                filled: true, child: Text("确定对话框"), onPressed: _onPress1),
            BlockButton(
                filled: true, child: Text("文字输入对话框"), onPressed: _onPress2),
            BlockButton(
                filled: true, child: Text("评价对话框"), onPressed: _onPress3),
          ],
        ),
      ),
    );
  }

  _onPress() {
    Dialog.of(context).alert("注意", "您正在做这种行为", () {
      toast("您已经搞定了");
    });
  }

  _onPress1() {
    Dialog.of(context).confirm("操作", "您确定要这样做吗?", () {
      toast("您已经确定就是要这样做");
    });
  }

  _onPress2() {
    Dialog.of(context).input("操作", "请写下您的意见以便我们改正", (str) {
      if (str == '')
        toast("您没有填写任何内容");
      else {
        toast("您填写的内容为:$str");
      }
    });
  }

  _onPress3() {
    Dialog.of(context).evaluation();
  }
}
