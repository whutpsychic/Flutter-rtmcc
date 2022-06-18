import 'package:flutter/material.dart';
import '../../core/MyPage/MyScaffold.dart';
import '../../UI/Video/main.dart';

class VideoPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<VideoPage> {
  String? _url;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _url =
            "http://qukufile2.qianqian.com/data2/video/d33d7035e19253b19f379b7f9aa98c6e/612987418/612987418.mp4";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      topSafe: true,
      backgroundColor: Colors.black,
      child: Container(
        child: Video(url: _url),
      ),
    );
  }
}
