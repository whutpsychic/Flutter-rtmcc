import 'package:flutter/material.dart';
import '../../core/MyPage/MyScaffold.dart';
import '../../UI/Photo/main.dart';

class PhotoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<PhotoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "图片浏览器",
      child: SingleChildScrollView(
        child: Column(children: [
          Photo(
            type: "asset",
            url: "assets/1.jpeg",
            child: Image.asset("assets/1.jpeg", width: 200),
          ),
          // Photo(
          //   type: "asset",
          //   url: "assets/2.jpeg",
          //   child: Image.asset("assets/2.jpeg", width: 300),
          // ),
          // Photo(
          //   type: "asset",
          //   url: "assets/3.jpeg",
          //   child: Image.asset("assets/3.jpeg", width: 300),
          // ),
        ]),
      ),
    );
  }

  _go(String url) {
    Navigator.of(context)
        .pushNamed("/pv", arguments: {"type": "asset", "url": url});
  }
}
