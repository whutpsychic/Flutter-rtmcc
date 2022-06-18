import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import '../../UI/Collapse/main.dart';
import './data.dart';

class CollapseItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<CollapseItems> with MyPage {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "折叠面板",
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Collapse(
            data: data,
            onTap: (x) {
              print(x);
            },
          ),
        ),
      ),
    );
  }
}
