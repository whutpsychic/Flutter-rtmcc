library util;

import 'dart:convert';
import 'package:flutter/material.dart';
part './testTools.dart';

// 路径监听
final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

class Util {
  // 测试log函数
  static Function log = TestTools.log;
  // 处理并获取页面参数
  static Map? getArgs(context) {
    var result = ModalRoute.of(context)?.settings.arguments;
    if (result != null) {
      return jsonDecode(jsonEncode(result));
    }
    return null;
  }

  // 修复在 initState 中使用不能立刻初始化的函数
  static void fixInit(Function() fun) {
    Future.delayed(Duration(milliseconds: 10), () {
      fun();
    });
  }
}
