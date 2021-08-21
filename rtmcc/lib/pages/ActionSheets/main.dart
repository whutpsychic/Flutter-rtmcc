import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../core/MyPage/main.dart';
import '../../UI/Button/main.dart';

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
              BlockButton(
                  filled: true, child: Text("弹出操作表"), onPressed: _onPress),
            ],
          ),
        ));
  }

  _onPress() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('请选择要进行的操作', style: TextStyle(fontSize: 16)),
        // message: const Text('选项'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('拍摄'),
            onPressed: () {
              Navigator.pop(context);
              toast("拍摄");
            },
          ),
          CupertinoActionSheetAction(
            child: Text('选择照片'),
            onPressed: () {
              toast("选择照片");
              Navigator.pop(context);
            },
          )
        ],
        cancelButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            toast('取消');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: Text(
              '取消',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.blue,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
