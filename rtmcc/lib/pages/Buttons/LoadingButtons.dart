import 'package:flutter/material.dart';
import '../../UI/Button/main.dart';

class LoadingButtons extends StatefulWidget {
  final Function onPress;
  final Function onLongPress;

  LoadingButtons({required this.onPress, required this.onLongPress});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<LoadingButtons> {
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
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            filled: true,
            loading: _loading1,
            size: Size(100, 36),
            child: Text('加载按钮1'),
            onPressed: () {
              widget.onPress("加载按钮1");
              _fakeLoad1();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Button(
            loading: _loading2,
            size: Size(100, 36),
            child: Text('加载按钮2'),
            onPressed: () {
              widget.onPress("加载按钮2");
              _fakeLoad2();
            },
          ),
        ),
      ],
    );
  }
}
