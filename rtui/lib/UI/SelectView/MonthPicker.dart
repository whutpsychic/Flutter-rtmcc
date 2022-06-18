// 月份选择器视图
// 默认设置为100年前至100年后
// 默认为当月
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './main.dart';

class MonthPicker extends StatefulWidget {
  final Key? key;
  final DateTime? defaultValue;
  MonthPicker({this.key, this.defaultValue}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MonthPickerState();
}

class MonthPickerState extends State<MonthPicker> {
  // 年数据源
  List<int> years = [];
  // 月数据源
  List<int> months = [];
  // 当前年选择项索引
  int currYI = 0;
  // 当前月选择项索引
  int currMI = 0;

  @override
  void initState() {
    super.initState();
    DateTime _now = DateTime.now();
    // 获得100年前
    int b100 = _now.year - 100;
    // 获得100年后
    int n100 = _now.year + 100;
    List<int> yresult = [];
    for (int i = b100; i < n100; i++) {
      yresult.add(i);
    }
    List<int> mresult = [];
    for (int i = 1; i < 13; i++) {
      mresult.add(i);
    }
    // 设置数据源
    setState(() {
      years = yresult;
      months = mresult;
    });

    // 默认数据
    if (widget.defaultValue != null) {
      int _curyi = yresult.indexWhere((el) => el == widget.defaultValue!.year);
      int _curmi = mresult.indexWhere((el) => el == widget.defaultValue!.month);

      setState(() {
        currYI = _curyi;
        currMI = _curmi;
      });
    }
    // 默认为今年本月
    else {
      int _curyi = yresult.indexWhere((el) => el == _now.year);
      int _curmi = mresult.indexWhere((el) => el == _now.month);

      setState(() {
        currYI = _curyi;
        currMI = _curmi;
      });
    }
  }

  DateTime getValue() {
    return DateTime(years[currYI], months[currMI]);
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: _screenWidth / 2,
          child: CupertinoPicker(
            itemExtent: Selector.itemHeight,
            scrollController: FixedExtentScrollController(initialItem: currYI),
            onSelectedItemChanged: (i) {
              setState(() {
                currYI = i;
              });
            },
            children: years
                .map<Widget>((el) => Container(
                      alignment: Alignment.center,
                      height: Selector.itemHeight,
                      child: Text(
                        "$el 年",
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
                .toList(),
          ),
        ),
        Container(
          width: _screenWidth / 2,
          child: CupertinoPicker(
            itemExtent: Selector.itemHeight,
            scrollController: FixedExtentScrollController(initialItem: currMI),
            onSelectedItemChanged: (i) {
              setState(() {
                currMI = i;
              });
            },
            children: months
                .map<Widget>((el) => Container(
                      alignment: Alignment.center,
                      height: Selector.itemHeight,
                      child: Text(
                        "$el 月",
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
