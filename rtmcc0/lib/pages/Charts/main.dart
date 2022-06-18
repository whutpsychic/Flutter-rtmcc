import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import '../../UI/List/main.dart';
import '../AllMenu/main.dart';

class Charts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Charts> with MyPage {
  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "所有图表",
      child: ListGroup(
        children: [
          MenuItem("柱状图", "/bar-chart"),
          MenuItem("折线图", "/line-chart"),
          MenuItem("饼图", "/pie-chart"),
        ],
      ),
    );
  }
}
