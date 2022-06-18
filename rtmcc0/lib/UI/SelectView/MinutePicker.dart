// 级联选择器视图
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './main.dart';

class MinutePicker extends StatefulWidget {
  final Key? key;
  final DateTime? defaultValue;
  MinutePicker({this.key, this.defaultValue}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MinutePickerState();
}

class MinutePickerState extends State<MinutePicker> {
  // 小时数据源
  List<int> hours = [];
  // 分钟数据源
  List<int> minutes = [];
  // 当前小时选择项索引
  int currHI = 0;
  // 当前分钟选择项索引
  int currMI = 0;

  @override
  void initState() {
    super.initState();

    List<int> harr = [];
    List<int> marr = [];
    int i = 0, j = 0;
    while (i < 24) {
      harr.add(i);
      i++;
    }
    while (j < 60) {
      marr.add(j);
      j++;
    }

    // 默认数据
    if (widget.defaultValue != null) {
      int _curhi = harr.indexWhere((el) => el == widget.defaultValue!.hour);
      int _curmi = marr.indexWhere((el) => el == widget.defaultValue!.minute);

      setState(() {
        currHI = _curhi;
        currMI = _curmi;
      });
    }
    // 默认为00:00
    else {
      setState(() {
        currHI = 0;
        currMI = 0;
      });
    }

    setState(() {
      hours = harr;
      minutes = marr;
    });
  }

  DateTime getValue() {
    return DateTime(0, 0, 0, hours[currHI], minutes[currMI]);
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
            scrollController: FixedExtentScrollController(initialItem: currHI),
            onSelectedItemChanged: (i) {
              setState(() {
                currHI = i;
              });
            },
            children: hours
                .map<Widget>((el) => Container(
                      alignment: Alignment.center,
                      height: Selector.itemHeight,
                      child: Text(
                        "$el 时",
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
            children: minutes
                .map<Widget>((el) => Container(
                      alignment: Alignment.center,
                      height: Selector.itemHeight,
                      child: Text(
                        "$el 分",
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
