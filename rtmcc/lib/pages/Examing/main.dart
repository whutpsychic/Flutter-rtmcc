import 'dart:async';
import 'package:flutter/material.dart' hide Dialog;
import '../../core/MyPage/main.dart';
import '../../core/Util/main.dart';
import '../../UI/Button/main.dart';
import '../../UI/Dialog/main.dart';
import '../../UI/Questions/main.dart';
import "./fakeDao.dart";

// 单选key
GlobalKey<SelectSingleState> ssk = GlobalKey();
// 多选key
GlobalKey<SelectMultiState> smk = GlobalKey();
// 单题内多选key
GlobalKey<SelectInnersState> ismk = GlobalKey();
// 填空题key
GlobalKey<FillInBlankState> fbk = GlobalKey();
// 判断题key
GlobalKey<JudgmentState> jgk = GlobalKey();
// 简答题key
GlobalKey<ShortAnswerState> sak = GlobalKey();

// 当前题目的key
dynamic currKey;

class Examing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Examing> with MyPage {
  //剩余时间(以秒为单位)
  int _timeRemained = 0;

  // 计时器
  Timer? tc;

  // 一共几道题
  int? total;

  // 当前第几题
  int num = 0;

  // 当前题目
  Map? currQuestion;

  @override
  initState() {
    super.initState();
    setState(() {
      _timeRemained = 3000;
    });

    didLoad(() {
      // 获取一共多少题
      Map? args = Util.getArgs(context);
      print(args?['total']);
      setState(() {
        total = args?['total'];
      });

      // 计时
      void ticker(timer) {
        if (_timeRemained <= 0) {
          // 计时结束时要解除计时器
          tc?.cancel();
          Dialog.of(context).toast("提交中,请稍后...");
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        } else {
          setState(() {
            _timeRemained -= 1;
          });
        }
      }

      tc = Timer.periodic(Duration(seconds: 1), ticker);

      _getQuestion();
    });
  }

  @override
  dispose() {
    // 离开页面时要解除计时器
    tc?.cancel();
    super.dispose();
  }

  // 根据剩余时间渲染时间组件
  Widget _renderTime(int x) {
    List<Color?> colors = [Colors.white, Colors.orange[600], Colors.red[600]];
    int hours = x ~/ 3600;
    int minutes = (x - hours * 3600) ~/ 60;
    int seconds = x - hours * 3600 - minutes * 60;
    excN(int y) {
      if (y < 10 && y >= 0) return "0$y";
      return y;
    }

    jc() {
      if (x < 30)
        return colors[2];
      else if (x < 300 && x >= 30) return colors[1];
      return colors[0];
    }

    return Container(
      width: 100,
      child: Text(
        "${excN(hours)}:${excN(minutes)}:${excN(seconds)}",
        style: TextStyle(color: jc()),
      ),
    );
  }

  // 获取题目
  _getQuestion() async {
    Dialog.of(context).toast("获取中...");
    Map? ques = await Dao.getNextQuestion(num);
    Navigator.of(context).pop();
    setState(() {
      num++;
      currQuestion = ques;
    });
  }

  // 下一题
  _onNext() {
    // 收起键盘
    FocusScope.of(context).requestFocus(FocusNode());
    var _currAnswer = currKey?.currentState.getValue();
    print(_currAnswer);
    Dialog.of(context).confirm(
      "确认提交本题答案吗？",
      "提交后将不可修改并自动为您请求下一道题",
      () {
        _fakeSubmit(_currAnswer).then((v) {
          if (v) {
            _getQuestion();
          } else {
            Navigator.of(context).pushNamed("/exam-complete");
          }
        });
      },
    );
  }

  // 模拟提交
  _fakeSubmit(dynamic answer) {
    Dialog.of(context).toast("处理中...");
    return Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
      if (num < total!) return true;
      return false;
    });
  }

  // 渲染题目
  _renderQuestion() {
    if (currQuestion != null) {
      switch (currQuestion!['type']) {
        case 1:
        case "1":
          currKey = ssk;
          return SelectSingle(key: ssk, body: currQuestion!);
        case 2:
        case "2":
          currKey = smk;
          return SelectMulti(key: smk, body: currQuestion!);
        case 3:
        case "3":
          currKey = ismk;
          return SelectInners(key: ismk, body: currQuestion!);
        case 4:
        case "4":
          currKey = fbk;
          return FillInBlank(key: fbk, body: currQuestion!);
        case 5:
        case "5":
          currKey = jgk;
          return Judgment(key: jgk, body: currQuestion!);
        case 6:
        case "6":
          currKey = sak;
          return ShortAnswer(key: sak, body: currQuestion!);
        case 7:
        case "7":
        default:
          return Container();
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Container(
        width: 240,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text('剩余时间'), _renderTime(_timeRemained)],
        ),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 84,
                    child: Text(
                      getQuestionTypeName(currQuestion?["type"]),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      "$num / ${total ?? '??'}",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Button(
                    child: Text("${num == total ? '交卷' : '下一题'}"),
                    onPressed: _onNext,
                    size: Size(100, 40),
                  )
                ],
              ),
              _renderQuestion()
            ],
          ),
        ),
      ),
    );
  }
}
