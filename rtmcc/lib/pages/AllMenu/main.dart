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
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListGroup(
                title: "通用组件",
                children: [
                  MenuItem("按钮", "/buttons"),
                  MenuItem("提示", "/toasts"),
                  MenuItem("对话框", "/dialogs"),
                  MenuItem("操作表", "/actionsheets"),
                  MenuItem("列表", "/list-items"),
                  MenuItem("选择器视图", "/select-views"),
                  MenuItem("表单", "/form-items"),
                  MenuItem("折叠面板", "/collapse-items"),
                  MenuItem("图片轮播", "/carousel"),
                  MenuItem("下拉刷新", "/pull-to-refresh"),
                ],
              ),
              ListGroup(
                title: "UI组件",
                children: [
                  MenuItem("图表", "/all-charts"),
                ],
              ),
              ListGroup(
                title: "功能组件",
                children: [
                  MenuItem("扫码", "/scanning"),
                  MenuItem("图片查看器", "/photo-view"),
                  MenuItem("访问相册", "/album"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String url;
  final Map? args;
  MenuItem(this.title, this.url, [this.args]);
  @override
  Widget build(BuildContext context) {
    return ListItem(
        title: title,
        arrow: true,
        onTap: () {
          Navigator.of(context).pushNamed(url, arguments: args);
        });
  }
}
