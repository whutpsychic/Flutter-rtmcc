import 'package:flutter/material.dart';
import '../util.dart';

class SelectInners extends StatefulWidget {
  final Map body;
  SelectInners({Key? key, required this.body}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SelectInnersState();
}

class SelectInnersState extends State<SelectInners> {
  // 题干
  String _mainQuestion = "";
  // 选项
  List<List<String>> _answers = [];
  // 当前选择索引
  List<int?> selected = [];

  @override
  void initState() {
    super.initState();

    // 设置渲染(以防在build层反复渲染)
    setState(() {
      _mainQuestion = widget.body['question'];
      _answers = widget.body['answers'];

      //计算长度并预答案位置
      for (int i = 0; i < _answers.length; i++) {
        selected.add(null);
      }

      print(selected);
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
    return _arrangeIndex(selected);
  }

  // 将答案排序
  _arrangeIndex(arr) {
    List _arr = [...arr];
    int mySortComparison(a, b) {
      if (a < b) {
        return -1;
      } else if (a > b) {
        return 1;
      } else {
        return 0;
      }
    }

    _arr.sort(mySortComparison);
    return _arr;
  }

  _renderAnswers() {
    int num = 0;
    return _answers.map((el) {
      int ik = num++;
      return Container(
        child: Column(children: [
          Text("(${ik + 1})"),
          ...el.map<Widget>((e) {
            int i = el.indexOf(e);
            return SelectItem(
              text: "${serilizedPrefix[i]}.$e",
              value: i,
              onTap: (v) => _onSelect(v, ik),
              active: selected[ik] == i,
            );
          }).toList(),
        ]),
      );
    }).toList();
  }

  _onSelect(v, i) {
    setState(() {
      selected[i] = v;
    });
  }
}
