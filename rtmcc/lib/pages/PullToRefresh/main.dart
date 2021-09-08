import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';

class PullToRefresh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<PullToRefresh> with MyPage {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "下拉刷新",
      child: Container(
        child: null,
      ),
    );
  }
}
