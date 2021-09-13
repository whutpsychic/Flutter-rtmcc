import 'package:flutter/material.dart';

// 柱子宽度
final double width = 16;

// 默认纵轴分5个档
final int num = 5;

// 饼图默认大小
final double pieSize = 150;

// 默认环大小
final double circleSize = 100;

// 颜色大类扩展
extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(alpha, (red * value).round(), (green * value).round(),
        (blue * value).round());
  }
}

// 色调
final List<Color> colors = [
  Color(0xff53fdd7),
  Color(0xffff5182),
  Color(0xff0293ee),
  Color(0xfff8b250),
  Color(0xff845bef),
  Color(0xff13d38e)
];
