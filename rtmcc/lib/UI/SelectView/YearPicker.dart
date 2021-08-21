// 年份选择器视图
// 默认设置为100年前至100年后
// 默认为今年
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './main.dart';

class YearPicker extends StatefulWidget {
  final Key? key;
  final int? defaultValue;
  YearPicker({this.key, this.defaultValue}) : super(key: key);

  @override
  State<StatefulWidget> createState() => YearPickerState();
}

class YearPickerState extends State<YearPicker> {
  // 数据源
  List<int> years = [];
  // 当前选择项索引
  int currI = 0;

  @override
  void initState() {
    super.initState();
    DateTime _now = DateTime.now();
    // 获得100年前
    int b100 = _now.year - 100;
    // 获得100年后
    int n100 = _now.year + 100;
    List<int> result = [];
    for (int i = b100; i < n100; i++) {
      result.add(i);
    }
    int thisy = _now.year;
    int ei;
    // 如果有默认值
    if (widget.defaultValue != null) {
      ei = result.indexWhere((element) => element == widget.defaultValue);
    }
    // 默认选择今年
    else {
      ei = result.indexWhere((element) => element == thisy);
    }

    setState(() {
      years = result;
      currI = ei;
    });
  }

  getValue() {
    return years[currI];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      itemExtent: Selector.itemHeight,
      scrollController: FixedExtentScrollController(initialItem: currI),
      onSelectedItemChanged: (i) {
        setState(() {
          currI = i;
        });
      },
      children: years
          .map<Widget>(
            (el) => Container(
              alignment: Alignment.center,
              height: Selector.itemHeight,
              child: Text(
                "$el 年",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
          .toList(),
    );
  }
}
