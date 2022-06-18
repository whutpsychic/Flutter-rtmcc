// 通用照片显示器
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import './main.dart';

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
            child: generateImage(imgArgs["type"], imgArgs["key"]),
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
