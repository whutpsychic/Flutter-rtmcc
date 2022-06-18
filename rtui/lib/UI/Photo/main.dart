export "./PhotoViewer.dart";
export "./PhotoPicker.dart";
// 通用照片显示器
import 'package:flutter/material.dart';

Image generateImage(String type, String url) {
  if (type == "asset" && url is String) {
    return Image.asset(url);
  } else if (type == "network" && url is String) {
    return Image.network(url);
  } else {
    return Image.asset("/");
  }
}

// ===========================
// url除了用于标定无子节点图片地址，还用于标明Hero的tag属性
// ===========================

class Photo extends StatefulWidget {
  final String type;
  final dynamic url;
  final Widget? child;
  Photo({required this.type, required this.url, this.child});
  State<StatefulWidget> createState() => PhotoState();
}

class PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    bool ec = widget.child != null;

    return GestureDetector(
      onTap: _go,
      child: Hero(
        tag: widget.url,
        child: ec ? widget.child! : generateImage(widget.type, widget.url),
      ),
    );
  }

  _go() {
    Navigator.of(context)
        .pushNamed("/pv", arguments: {"key": widget.url, "type": widget.type});
  }
}
