import 'package:flutter/material.dart';

class TextButtons extends StatefulWidget {
  final Function onPress;
  final Function onLongPress;

  TextButtons({required this.onPress, required this.onLongPress});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<TextButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        TextButton(
          onPressed: () {
            widget.onPress("文字按钮1");
          },
          onLongPress: () {
            widget.onLongPress("文字按钮1");
          },
          child: Text("文字按钮1"),
        ),
        TextButton(
          onPressed: () {
            widget.onPress("文字按钮2");
          },
          onLongPress: () {
            widget.onLongPress("文字按钮2");
          },
          child: Text(
            "文字按钮2",
            style: TextStyle(
              color: Colors.green,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onPress("文字按钮3");
          },
          onLongPress: () {
            widget.onLongPress("文字按钮3");
          },
          child: Text(
            "文字按钮3",
            style: TextStyle(
              color: Colors.red,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onPress("文字按钮4");
          },
          onLongPress: () {
            widget.onLongPress("文字按钮4");
          },
          child: Text(
            "文字按钮4",
            style: TextStyle(
              color: Colors.purple,
              decoration: TextDecoration.overline,
              decorationStyle: TextDecorationStyle.dotted,
              textBaseline: TextBaseline.ideographic,
            ),
          ),
        ),
      ],
    );
  }
}
