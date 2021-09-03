import 'dart:async';
import '../../static/questions.dart';

const questions = [
  // q_sort,
  q_selectSingle,
  q_selectMulti,
  q_selectBlank,
  q_fillInBlank,
  q_judgement,
  q_shortAnswer,
];

class Dao {
  // 模拟取得下一题
  static Future<Map?> getNextQuestion(i) {
    // 模拟请求流程需要2s
    return Future.delayed(Duration(milliseconds: 1500), () {
      // 请求第几题
      if (i < questions.length) {
        return questions[i];
      }
      // 未请求到任何题目
      else {
        return null;
      }
    });
  }
}
