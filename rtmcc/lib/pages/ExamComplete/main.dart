import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import '../../UI/Button/main.dart';

class ExamComplete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamCompleteState();
}

class _ExamCompleteState extends State<ExamComplete> with MyPage {
  // 计时器
  Timer? tc;
  // 还剩几秒
  int least = 5;

  @override
  initState() {
    super.initState();
    didLoad(() {
      // 计时
      void ticker(timer) {
        if (least <= 0) {
          _backoff();
        } else {
          setState(() {
            least -= 1;
          });
        }
      }

      tc = Timer.periodic(Duration(seconds: 1), ticker);
    });
  }

  void _backoff() {
    Navigator.of(context)
        .popUntil((route) => route.settings.name == "/all-menu");
  }

  @override
  dispose() {
    // 离开页面时要解除计时器
    tc?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      disableGesturePop: true,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.green,
              ),
              child: Icon(
                Icons.check,
                size: 60,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                "您已经完成了考试，$least秒后自动返回",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Button(
              outlined: true,
              child: Text("立即返回"),
              onPressed: _backoff,
              size: Size(100, 40),
            )
          ],
        ),
      ),
    );
  }
}
