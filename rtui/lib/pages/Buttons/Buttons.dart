import 'package:flutter/material.dart';
import '../../UI/Button/Button.dart';
import '../../UI/Button/main.dart';

class NormalButtons extends StatefulWidget {
  final Function onPress;
  final Function onLongPress;

  NormalButtons({required this.onPress, required this.onLongPress});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<NormalButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
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
            size: Size(100, 36),
            child: Text(
              '普通按钮5',
              style: TextStyle(color: Colors.grey[800]),
            ),
            onPressed: () {
              widget.onPress("普通按钮5");
            },
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }
}
