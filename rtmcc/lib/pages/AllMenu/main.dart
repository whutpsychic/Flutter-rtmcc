// 所有页面入口清单
import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import '../../UI/List/main.dart';

class AllMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<AllMenu> with MyPage {
  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "菜单",
      child: ListGroup(
        title: "通用组件",
        children: [
          MenuItem("按钮", "/buttons"),
          MenuItem("提示", "/toasts"),
          MenuItem("对话框", "/dialogs"),
          MenuItem("操作表", "/actionsheets"),
          MenuItem("列表", "/list-items"),
          MenuItem("选择器视图", "/select-views"),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String url;
  MenuItem(this.title, this.url);
  @override
  Widget build(BuildContext context) {
    return ListItem(
        title: title,
        arrow: true,
        onTap: () {
          Navigator.of(context).pushNamed(url);
        });
  }
}
