// 月份选择器视图
// 默认设置为100年前至100年后
// 默认为当月
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './main.dart';

class DatePicker extends StatefulWidget {
  final Key? key;
  final DateTime? defaultValue;
  DatePicker({this.key, this.defaultValue}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  // 年数据源
  List<int> years = [];
  // 月数据源
  List<int> months = [];
  // 日数据源
  List<int> days = [];

  // 当前年选择项索引
  int currYI = 0;
  // 当前月选择项索引
  int currMI = 0;
  // 当前日选择项索引(默认是今天)
  int currDI = DateTime.now().day - 1;

  late FixedExtentScrollController dc;

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

      // 默认数据
      if (widget.defaultValue != null) {
        int _curyi =
            yresult.indexWhere((el) => el == widget.defaultValue!.year);
        int _curmi =
            mresult.indexWhere((el) => el == widget.defaultValue!.month);
        List arr = renderDates(yresult[_curyi], mresult[_curmi], true);
        currYI = _curyi;
        currMI = _curmi;

        // 日的默认值设定
        int _curdi = arr.indexWhere((el) => el == widget.defaultValue!.day);
        currDI = _curdi;
        dc = FixedExtentScrollController(initialItem: _curdi);
      }
      // 默认为今年本月
      else {
        dc = FixedExtentScrollController(initialItem: currDI);
        int _curyi = yresult.indexWhere((el) => el == _now.year);
        int _curmi = mresult.indexWhere((el) => el == _now.month);
        renderDates(yresult[_curyi], mresult[_curmi]);
        currYI = _curyi;
        currMI = _curmi;
      }
    });
  }

  DateTime getValue() {
    return DateTime(years[currYI], months[currMI], days[currDI]);
  }

  // 根据年月设定日期数据源和默认值
  List renderDates(int y, int m, [bool? init]) {
    int total;

    switch (m) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        total = 31;
        break;
      case 4:
      case 6:
      case 9:
      case 11:
        total = 30;
        break;
      case 2:
        // 闰年判断法
        // 先判断年整除100 能则再判断年整除400，能=>闰年,不能=>非闰年
        // 不能整除100，再判断年整除4，能=>闰年,不能=>非闰年
        if (y % 100 == 0) {
          // 百年闰年
          if (y % 400 == 0) {
            total = 29;
            break;
          }
          // 百年非闰年
          else {
            total = 28;
            break;
          }
        } else {
          // 一般闰年
          if (y % 4 == 0) {
            total = 29;
            break;
          }
          // 一般非闰年
          else {
            total = 28;
            break;
          }
        }
      default:
        total = 30;
        break;
    }

    List<int> arr = [];
    int i = 1;
    while (i <= total) {
      arr.add(i);
      i++;
    }

    setState(() {
      days = arr;
      if (init != null && init) {
      } else {
        // fixed
        if (currDI > arr.length - 1) {
          currDI = arr.length - 1;
          dc.jumpToItem(currDI);
        } else {
          dc.jumpToItem(currDI - 1 < 0 ? 0 : currDI - 1);
          dc.jumpToItem(currDI + 1);
        }
      }
    });
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: _screenWidth / 3,
          child: CupertinoPicker(
            itemExtent: Selector.itemHeight,
            scrollController: FixedExtentScrollController(initialItem: currYI),
            onSelectedItemChanged: (i) {
              setState(() {
                currYI = i;
              });
              renderDates(years[i], months[currMI]);
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
          width: _screenWidth / 3,
          child: CupertinoPicker(
            itemExtent: Selector.itemHeight,
            scrollController: FixedExtentScrollController(initialItem: currMI),
            onSelectedItemChanged: (i) {
              setState(() {
                currMI = i;
              });
              renderDates(years[currYI], months[i]);
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
        ),
        Container(
          width: _screenWidth / 3,
          child: CupertinoPicker(
            itemExtent: Selector.itemHeight,
            scrollController: dc,
            onSelectedItemChanged: (i) {
              setState(() {
                currDI = i;
              });
            },
            children: days
                .map<Widget>((el) => Container(
                      alignment: Alignment.center,
                      height: Selector.itemHeight,
                      child: Text(
                        "$el 日",
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
