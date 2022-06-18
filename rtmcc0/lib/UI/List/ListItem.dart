import 'package:flutter/material.dart';
import './ListItemCore.dart';

class ListItem extends StatefulWidget {
  final String? title;
  final Widget? extra;
  final Widget? leader;
  final bool? arrow;
  final Function()? onTap;
  ListItem({this.title, this.extra, this.leader, this.arrow, this.onTap});

  static Function info = _generateExtraInfo;
  static Function badge = _generateExtraBadge;
  static Function icon = _generateIcon;

  @override
  State<StatefulWidget> createState() => ListItemState();
}

class ListItemState extends State<ListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    Widget e = widget.extra != null
        ? Container(
            child: widget.extra,
            constraints: BoxConstraints(maxWidth: _screenWidth * 70 / 100),
          )
        : Container();
    Widget i =
        widget.leader != null ? Container(child: widget.leader) : Container();

    Widget a = widget.arrow != null && widget.arrow!
        ? Icon(Icons.keyboard_arrow_right, color: Colors.grey[500])
        : Container();
    return ListItemCore(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        width: _screenWidth,
        height: ListItemCore.height,
        padding: EdgeInsets.only(left: 4, right: 12),
        margin: EdgeInsets.only(left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                i,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  constraints: BoxConstraints(maxWidth: _screenWidth / 2),
                  child: Text(
                    widget.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(children: [e, a])
          ],
        ),
      ),
    );
  }
}

// 默认额外信息
Widget _generateExtraInfo(dynamic text) {
  return Container(
    child: Text(text.toString(),
        style: TextStyle(fontSize: 16, color: Colors.grey)),
  );
}

// 默认右侧角标
Widget _generateExtraBadge(int num) {
  const double size = 22;
  return Container(
    alignment: Alignment.center,
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(size / 2),
    ),
    child: Text(
      num.toString(),
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
}

// 默认左侧图标
Widget _generateIcon(Widget icon, [Color? color]) {
  const double size = 30;
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color ?? Colors.blue,
      borderRadius: BorderRadius.circular(6),
    ),
    child: icon,
  );
}
