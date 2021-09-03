library util;

import 'dart:convert';
import 'package:flutter/material.dart';
part './testTools.dart';

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
}
