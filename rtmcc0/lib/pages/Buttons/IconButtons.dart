import 'package:flutter/material.dart';
import '../../UI/Button/main.dart';

class IconButtons extends StatefulWidget {
  final Function onPress;
  final Function onLongPress;

  IconButtons({required this.onPress, required this.onLongPress});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<IconButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            icon: Icon(Icons.search),
            size: Size(128, 36),
            child: Text('普通按钮1'),
            onPressed: () {
              widget.onPress("普通按钮1");
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            icon: Icon(Icons.flag),
            size: Size(128, 36),
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
            icon: Icon(Icons.car_rental),
            size: Size(128, 36),
            child: Text('普通按钮3'),
            onPressed: () {
              widget.onPress("普通按钮3");
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            outlined: true,
            icon: Icon(Icons.screen_lock_landscape),
            size: Size(128, 36),
            child: Text('普通按钮4'),
            onPressed: () {
              widget.onPress("普通按钮4");
            },
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
