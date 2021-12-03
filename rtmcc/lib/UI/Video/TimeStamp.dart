import 'package:flutter/material.dart';
import './config.dart';

// 将小于10的数字前缀0后返回
String execNumber(int x) {
  if (x < 10)
    return "0$x";
  else {
    return "$x";
  }
}

class TimeStamp extends StatelessWidget {
  final int? seconds;
  TimeStamp(this.seconds);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _transform(),
        style: TextStyle(color: styleColor, fontSize: timeStampSize),
      ),
    );
  }

  String _transform() {
    // 如果有数据
    if (seconds != null) {
      int _s = 0, _m = 0, _h = 0;
      // 计算秒数
      _m = (seconds! ~/ 60);
      _s = seconds! - _m * 60;

      // 计算分钟数
      _h = _m ~/ 60;
      _m = _m - _h * 60;

      if (_h > 0) {
        return "${execNumber(_h)}:${execNumber(_m)}:${execNumber(_s)}";
      } else {
        return "${execNumber(_m)}:${execNumber(_s)}";
      }
    }

    return "00:00";
  }
}
