import 'package:flutter/material.dart';
import '../util.dart';

class SelectSingle extends StatefulWidget {
  final Map body;
  SelectSingle({Key? key, required this.body}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SelectSingleState();
}

class SelectSingleState extends State<SelectSingle> {
  // 题干
  String _mainQuestion = "";
  // 选项
  List<String?> _answers = [];
  // 当前选择索引
  int? selected;

  @override
  void initState() {
    super.initState();

    // 设置渲染(以防在build层反复渲染)
    setState(() {
      _mainQuestion = widget.body['question'];
      _answers = widget.body['answers'];
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
        ..._renderAnswers(),
      ],
    );
  }

  getValue() {
    return selected;
  }

  _renderAnswers() {
    return _answers.map<Widget>((e) {
      int i = _answers.indexOf(e);
      return SelectItem(
        text: "${serilizedPrefix[i]}.$e",
        value: i,
        onTap: _onSelect,
        active: i == selected,
      );
    }).toList();
  }

  _onSelect(v) {
    setState(() {
      selected = v;
    });
  }
}
