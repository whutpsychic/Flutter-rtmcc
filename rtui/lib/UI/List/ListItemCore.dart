import 'package:flutter/material.dart';

class ListItemCore extends StatefulWidget {
  final bool? hl;
  final Widget child;
  final Function()? onTap;
  ListItemCore({required this.child, this.hl, this.onTap});

  static double height = 45;

  static Function info = _generateExtraInfo;
  static Function badge = _generateExtraBadge;
  static Function icon = _generateIcon;

  @override
  State<StatefulWidget> createState() => ListItemCoreState();
}

class ListItemCoreState extends State<ListItemCore> {
  bool _active = false;

  _getItHighLight(x) {
    setState(() {
      _active = true;
    });
  }

  _cancelHighLight(x) {
    setState(() {
      _active = false;
    });
  }

  _cancelHighLight2() {
    setState(() {
      _active = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool launchHighlight = widget.hl != null && !widget.hl! ? false : true;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: launchHighlight ? _getItHighLight : null,
      onTapUp: launchHighlight ? _cancelHighLight : null,
      onTapCancel: launchHighlight ? _cancelHighLight2 : null,
      child: Container(
        decoration:
            BoxDecoration(color: _active ? Color(0xFFdddddd) : Colors.white),
        child: widget.child,
      ),
    );
  }
}

Widget _generateExtraInfo(String text) {
  return Container(
    child: Text(text, style: TextStyle(fontSize: 16, color: Colors.grey)),
  );
}

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
