// 页面通用代码段
import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  final Widget child;
  final dynamic title;
  final bool? disableGesturePop;
  final bool? safe;

  MyScaffold(
      {required this.child, this.title, this.disableGesturePop, this.safe});

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
    // 是否是安全显示区域(默认不安全)
    bool _safe = widget.safe != null && widget.safe!;

    return GestureDetector(
      // 点击app体可使键盘回收
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: _renderTitle(),
        body: _canpop
            ? SafeArea(
                top: _safe,
                bottom: _safe,
                child: Container(
                  width: _screenWidth,
                  height: _screenHeight,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: widget.child,
                ),
              )
            : SafeArea(
                top: _safe,
                bottom: _safe,
                child: WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Container(
                    width: _screenWidth,
                    height: _screenHeight,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: widget.child,
                  ),
                ),
              ),
      ),
    );
  }
}
