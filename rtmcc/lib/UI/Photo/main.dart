// 通用照片显示器
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

Image _generateImage(String type, String url) {
  if (type == "asset") {
    return Image.asset(url);
  } else if (type == "network") {
    return Image.network(url);
  } else {
    return Image.asset("/");
  }
}

class Photo extends StatefulWidget {
  final String type;
  final String url;
  final Widget? child;
  Photo({required this.type, required this.url, this.child});
  State<StatefulWidget> createState() => PhotoState();
}

class PhotoState extends State<Photo> {
  var key;

  @override
  Widget build(BuildContext context) {
    bool ec = widget.child != null;

    return GestureDetector(
      onTap: _go,
      child: Hero(
        tag: "$key",
        child: ec ? widget.child! : _generateImage(widget.type, widget.url),
      ),
    );
  }

  _go() {
    var _key = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      key = _key;
      print(key);
    });
    Navigator.of(context).pushNamed("/pv",
        arguments: {"key": _key, "type": widget.type, "url": widget.url});
  }
}

class PhotoViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;

    var args = ModalRoute.of(context)!.settings.arguments;
    Map imgArgs = jsonDecode(jsonEncode(args));

    return GestureDetector(
      onTap: _back,
      child: Container(
        width: _w,
        height: _h,
        color: Colors.black,
        child: Hero(
          tag: imgArgs['key'],
          child: PinchZoom(
            child: _generateImage(imgArgs["type"], imgArgs["url"]),
            resetDuration: const Duration(milliseconds: 100),
            maxScale: 2.5,
          ),
        ),
      ),
    );
  }

  _back() {
    Navigator.of(context).pop();
  }
}
