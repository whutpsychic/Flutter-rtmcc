import 'package:flutter/material.dart';
import '../util.dart';

class SelectMulti extends StatefulWidget {
  final Map body;
  SelectMulti({Key? key, required this.body}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SelectMultiState();
}

class SelectMultiState extends State<SelectMulti> {
  // 题干
  String _mainQuestion = "";
  // 选项
  List<String?> _answers = [];
  // 当前选择索引
  List<int?> selected = [];

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
    return _answers.map<Widget>((e) {
      int i = _answers.indexOf(e);
      return SelectItem(
        text: "${serilizedPrefix[i]}.$e",
        value: i,
        onTap: _onSelect,
        active: hasIt(selected, i),
      );
    }).toList();
  }

  _onSelect(v) {
    setState(() {
      bool _exist = hasIt(selected, v);
      // 如果已存在，则该移出之
      if (_exist) {
        selected.remove(v);
      }
      // 如果不存在，则记录之
      else {
        // 插入此项并且注意去重
        Set<int?> el = new Set<int?>();
        el.addAll([...selected, v]);
        selected = el.toList();
      }
    });
  }
}
