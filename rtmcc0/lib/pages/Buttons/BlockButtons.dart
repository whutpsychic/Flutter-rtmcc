import 'package:flutter/material.dart';
import '../../UI/Button/main.dart';

class BlockButtons extends StatefulWidget {
  final Function onPress;
  final Function onLongPress;

  BlockButtons({required this.onPress, required this.onLongPress});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<BlockButtons> {
  bool _loading1 = false;
  bool _loading2 = false;

  _fakeLoad1() {
    setState(() {
      _loading1 = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loading1 = false;
      });
    });
  }

  _fakeLoad2() {
    setState(() {
      _loading2 = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loading2 = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: BlockButton(
            outlined: true,
            child: Text("块级按钮1"),
            onPressed: () {
              widget.onPress("块级按钮1");
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: BlockButton(
            outlined: true,
            child: Text("块级按钮2"),
            onPressed: () {
              _fakeLoad1();
              widget.onPress("块级按钮2");
            },
            loading: _loading1,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: BlockButton(
            child: Text("块级按钮3"),
            onPressed: () {
              _fakeLoad2();
              widget.onPress("块级按钮3");
            },
            loading: _loading2,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: BlockButton(
            child: Text("块级按钮4"),
            onPressed: () {
              widget.onPress("块级按钮4");
            },
            color: Colors.red,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: BlockButton(
            child: Text("块级按钮5"),
            onPressed: () {
              widget.onPress("块级按钮5");
            },
            color: Colors.orange,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: BlockButton(
            child: Text("块级按钮6"),
            onPressed: () {
              widget.onPress("块级按钮6");
            },
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
