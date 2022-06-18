import 'package:flutter/material.dart';

const double itemHeight = 40;

List<Color> colors = [Color(0xFFdddddd), Colors.white];

class Collapse extends StatefulWidget {
  final List data;
  final Function(dynamic x)? onTap;
  Collapse({required this.data, this.onTap});
  @override
  State<StatefulWidget> createState() => CollapseState();
}

class CollapseState extends State<Collapse> {
  int active = 0;

  @override
  Widget build(BuildContext context) {
    int i = -1;
    return Column(
        children: widget.data.map((e) {
      i++;
      return CollapseContainer(
        index: i,
        extended: active == i,
        child: e['title'],
        children: e['children'],
        onChange: _onChange,
        data: e['data'],
      );
    }).toList());
  }

  _onChange(x, self) {
    setState(() {
      active = x;
    });
    if (widget.onTap != null) {
      widget.onTap!(self);
    }
  }
}

class CollapseContainer extends StatefulWidget {
  final Widget child;
  final List<Map> children;
  final bool extended;
  final Function(int x, dynamic self) onChange;
  final int index;
  final dynamic data;
  CollapseContainer({
    required this.index,
    required this.child,
    required this.children,
    required this.extended,
    required this.onChange,
    this.data,
  });

  @override
  State<StatefulWidget> createState() => CollapseContainerState();
}

class CollapseContainerState extends State<CollapseContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _sw = MediaQuery.of(context).size.width;
    return Container(
      width: _sw,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              widget.onChange(widget.index, widget.data);
            },
            child: Container(
              height: itemHeight + 10,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: colors[0],
                border: Border(
                  top: BorderSide(width: 1, color: Color(0xffeeeeee)),
                  bottom: BorderSide(width: 1, color: Color(0xffeeeeee)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.child,
                  widget.extended
                      ? Icon(Icons.keyboard_arrow_down)
                      : Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
          widget.extended
              ? Container(
                  width: _sw,
                  child: Column(
                    children: widget.children
                        .map<Widget>((Map e) => CollapseItem(
                              child: e['widget'],
                              data: e['data'],
                              onTap: (x) => widget.onChange(widget.index, x),
                            ))
                        .toList(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class CollapseItem extends StatefulWidget {
  final Widget child;
  final dynamic data;
  final Function(dynamic x) onTap;
  CollapseItem({required this.child, this.data, required this.onTap});
  @override
  State<StatefulWidget> createState() => CollapseItemState();
}

class CollapseItemState extends State<CollapseItem> {
  @override
  Widget build(BuildContext context) {
    double _sw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: _sw,
        height: itemHeight,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: colors[1],
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xffeeeeee)),
          ),
        ),
        child: widget.child,
      ),
    );
  }

  _onTap() {
    widget.onTap(widget.data);
  }
}
