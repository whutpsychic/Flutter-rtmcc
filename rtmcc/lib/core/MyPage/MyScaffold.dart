// 页面通用代码段
import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  final Widget child;
  final String? title;

  MyScaffold({required this.child, this.title});

  @override
  State<StatefulWidget> createState() => MyScaffoldState();
}

class MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? "")),
      body: Container(
        width: _screenWidth,
        height: _screenHeight,
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: widget.child,
      ),
    );
  }
}
