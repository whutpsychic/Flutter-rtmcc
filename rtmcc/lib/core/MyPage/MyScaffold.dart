// 页面通用代码段
import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  final Widget child;
  final dynamic title;
  final bool? disableGesturePop;
  final bool? topSafe;
  final bool? bottomSafe;
  final Color? backgroundColor;

  MyScaffold(
      {required this.child,
      this.title,
      this.disableGesturePop,
      this.topSafe,
      this.bottomSafe,
      this.backgroundColor});

  @override
  State<StatefulWidget> createState() => MyScaffoldState();
}

class MyScaffoldState extends State<MyScaffold> {
  _renderTitle() {
    if (widget.title != null) {
      if (widget.title is String) {
        return AppBar(title: Text(widget.title ?? ""));
      } else if (widget.title is Widget) {
        return AppBar(title: widget.title);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    // 是否可以手势回退(默认可以)
    bool _canpop =
        !(widget.disableGesturePop != null && widget.disableGesturePop!);

    // 默认背景色
    Color bg = widget.backgroundColor != null
        ? widget.backgroundColor!
        : Colors.grey[200]!;

    return GestureDetector(
      // 点击app体可使键盘回收
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: _renderTitle(),
        body: _canpop
            ? Container(
                decoration: BoxDecoration(color: bg),
                child: SafeArea(
                  top: widget.topSafe ?? false,
                  bottom: widget.bottomSafe ?? false,
                  child: Container(
                    width: _screenWidth,
                    height: _screenHeight,
                    child: widget.child,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(color: bg),
                child: SafeArea(
                  top: widget.topSafe ?? false,
                  bottom: widget.bottomSafe ?? false,
                  child: WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: Container(
                      width: _screenWidth,
                      height: _screenHeight,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
