import 'package:flutter/material.dart';

class FormStyle {
  // 必填项红色星星
  static final Widget isRequiredStar =
      Text("*", style: TextStyle(fontSize: 20, color: Colors.red));
  // 通用label样式
  static final TextStyle labelStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  // 通用教研错误文字样式
  static final TextStyle errTextStyle =
      TextStyle(fontSize: 14, color: Colors.red);
  // 单项高度
  static const double itemHeight = 40;
  // 通用disabled样式
  static final Color disabledColor = Colors.grey;
  // 通用内容文字样式
  static final TextStyle textStyle = TextStyle(fontSize: 16);
  // 通用内容文字样式
  static final TextStyle disabledTextStyle =
      TextStyle(fontSize: 16, color: Colors.grey);
}
