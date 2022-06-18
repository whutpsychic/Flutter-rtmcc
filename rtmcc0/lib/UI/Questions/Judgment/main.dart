import 'package:flutter/material.dart';
import '../util.dart';

class Judgment extends StatefulWidget {
  final Map body;
  Judgment({Key? key, required this.body}) : super(key: key);
  @override
  State<StatefulWidget> createState() => JudgmentState();
}

class JudgmentState extends State<Judgment> {
  // 题干
  String _mainQuestion = "";

  // 对/错
  int? value;

  @override
  void initState() {
    super.initState();

    // 设置渲染(以防在build层反复渲染)
    setState(() {
      _mainQuestion = widget.body['question'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Text(
            "\t\t\t\t$_mainQuestion",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        _renderAnswers(),
      ],
    );
  }

  getValue() {
    return value;
  }

  _renderAnswers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectItem(
          text: "",
          child: Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            child: Text("正确"),
          ),
          value: 1,
          size: Size(100, 50),
          active: value == 1,
          onTap: _onSelect,
        ),
        SelectItem(
          text: "",
          child: Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            child: Text("错误"),
          ),
          value: 0,
          size: Size(100, 50),
          active: value == 0,
          onTap: _onSelect,
        )
      ],
    );
  }

  _onSelect(v) {
    setState(() {
      value = v;
    });
  }
}
