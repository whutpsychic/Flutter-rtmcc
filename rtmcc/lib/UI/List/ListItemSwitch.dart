import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './ListItemCore.dart';

class ListItemSwitch extends StatefulWidget {
  final String? title;
  final Widget? extra;
  final Widget? leader;
  final Function? onChange;
  ListItemSwitch({this.title, this.extra, this.leader, this.onChange});
  @override
  State<StatefulWidget> createState() => ListItemSwitchState();
}

class ListItemSwitchState extends State<ListItemSwitch> {
  bool _launched = false;
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    Widget e =
        widget.extra != null ? Container(child: widget.extra) : Container();
    Widget i =
        widget.leader != null ? Container(child: widget.leader) : Container();

    return ListItemCore(
      hl: false,
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
                  child: Text(
                    widget.title ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(children: [
              e,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: CupertinoSwitch(
                  value: _launched,
                  onChanged: (v) {
                    setState(() {
                      _launched = v;
                    });
                    if (widget.onChange != null) widget.onChange!(v);
                  },
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
