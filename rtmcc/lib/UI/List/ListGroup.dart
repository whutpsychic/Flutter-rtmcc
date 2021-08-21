import 'package:flutter/material.dart';

class ListItemSpliter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: _screenWidth - 20,
      height: 0.5,
      decoration: BoxDecoration(color: Color(0xffdddddd)),
    );
  }
}

class ListGroupSpliter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Container(width: _screenWidth, height: 20);
  }
}

class ListGroup extends StatefulWidget {
  final String? title;
  final List<Widget> children;
  ListGroup({required this.children, this.title});
  @override
  State<StatefulWidget> createState() => ListGroupState();
}

class ListGroupState extends State<ListGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Container(
                padding: EdgeInsets.all(8),
                child: Text(widget.title ?? ""),
              )
            : Container(),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1, color: Color(0xffdddddd)),
                bottom: BorderSide(width: 1, color: Color(0xffdddddd)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _renderChildren(),
              // children: widget.children,
            ),
          ),
        )
      ],
    );
  }

  _renderChildren() {
    List<Widget> result = [];
    widget.children.forEach((el) {
      result.add(el);
      if (el != widget.children.last) result.add(ListItemSpliter());
    });

    return result;
  }
}
