// 页面通用代码段
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../UI/Toast/main.dart';

class MyPage {
  // 页面初始化
  void init(BuildContext context) {
    // Toast模块初始化
    Toast.init(context);
  }

  // 通用打印（调试时）
  void log(dynamic obj) {
    print(' ==================== debug log ==================== ');
    print(obj);
  }

  // 通用短提示
  void toast(String info, [int? l]) {
    Toast.showToast(info, l);
  }

  // 加载成功后执行
  void didLoad(Function callback) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      callback();
    });
  }
}
