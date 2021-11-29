import 'package:flutter/material.dart';
import '../../core/MyPage/MyScaffold.dart';

class Album extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Album> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "访问相册",
      child: Text("访问相册"),
    );
  }
}
