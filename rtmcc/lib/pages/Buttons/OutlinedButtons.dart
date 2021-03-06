import 'package:flutter/material.dart';
import '../../UI/Button/main.dart';

class NormalButtons2 extends StatefulWidget {
  final Function onPress;
  final Function onLongPress;

  NormalButtons2({required this.onPress, required this.onLongPress});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<NormalButtons2> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            outlined: true,
            size: Size(100, 36),
            child: Text('普通按钮1'),
            onPressed: () {
              widget.onPress("普通按钮1");
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            outlined: true,
            size: Size(100, 36),
            child: Text('普通按钮2'),
            onPressed: () {
              widget.onPress("普通按钮2");
            },
            color: Colors.red,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            outlined: true,
            size: Size(100, 36),
            child: Text('普通按钮3'),
            onPressed: () {
              widget.onPress("普通按钮3");
            },
            color: Colors.green,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            outlined: true,
            size: Size(100, 36),
            child: Text('普通按钮4'),
            onPressed: () {
              widget.onPress("普通按钮4");
            },
            color: Colors.purple,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            outlined: true,
            size: Size(100, 36),
            child: Text('普通按钮5'),
            onPressed: () {
              widget.onPress("普通按钮5");
            },
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
