import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import '../../UI/List/main.dart';
import '../../UI/SelectView/main.dart';
import '../../static/main.dart';

String excNumber(int) {
  if (int < 10) return "0$int";
  return "$int";
}

class SelectViews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<SelectViews> with MyPage {
  Map selectItem1 = {};
  List<Map> selectItem2 = [];
  List<Map> selectItem3 = [];
  Map? selectItem4;
  // ====================
  DateTime? year;
  DateTime? ym;
  DateTime? ymd;
  DateTime? hm;
  List? city;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "选择器视图",
      child: Container(
        child: Column(
          children: [
            ListGroup(
              title: "基础选择器",
              children: [
                ListItem(
                  title: "一般选择器",
                  onTap: _onPress,
                  extra: ListItem.info(selectItem1['name'] ?? ""),
                ),
                ListItem(
                  title: "多列选择器",
                  onTap: _onPress2,
                  extra: ListItem.info(
                      selectItem2.map((e) => e['name']).toList().join("-")),
                ),
                ListItem(
                  title: "级联选择器",
                  onTap: _onPress3,
                  extra: ListItem.info(
                      selectItem3.map((e) => e['name']).toList().join("-")),
                ),
                ListItem(
                  title: "树形选择器",
                  onTap: _onPress4,
                  extra: ListItem.info(selectItem4?['name'] ?? ""),
                ),
              ],
            ),
            ListGroup(
              title: "封装的选择器",
              children: [
                ListItem(
                  title: "年份选择器",
                  onTap: _onPressYear,
                  extra: ListItem.info(year != null ? "${year!.year}年" : ""),
                ),
                ListItem(
                  title: "月份选择器",
                  onTap: _onPressMonth,
                  extra: ListItem.info(
                      ym != null ? '${ym?.year}年${ym?.month}月' : ""),
                ),
                ListItem(
                  title: "日期选择器",
                  onTap: _onPressDate,
                  extra: ListItem.info(ymd != null
                      ? '${ymd?.year}年${ymd?.month}月${ymd?.day}日'
                      : ""),
                ),
                ListItem(
                  title: "时分选择器",
                  onTap: _onPressMinute,
                  extra: ListItem.info(hm != null
                      ? '${excNumber(hm?.hour)} : ${excNumber(hm?.minute)}'
                      : ""),
                ),
                ListItem(
                  title: "市区选择器",
                  onTap: _onPressCity,
                  extra: _renderCityName(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _renderCityName() {
    if (city != null) {
      String result = "";
      result += "${city?[0]?['name']}-";
      if (city?[1]['name'] != city?[0]['name'] &&
          city?[1]['code'] != city?[0]['code']) {
        result += "${city?[1]?['name']}-";
      }
      result += "${city?[2]?['name']}";
      return ListItem.info(result);
    }
  }

  _onPress() {
    Selector.of(context).show(
      data: selectData,
      value: selectItem1['value'],
      onChange: (it, i) {
        setState(() {
          selectItem1 = it;
        });
      },
    );
  }

  _onPress2() {
    Selector.of(context).showMulti(
      titles: ["第一列", "第二列", "第三列"],
      data: [selectData, selectData2, selectData3],
      value: selectItem2.map((e) => e['value']).toList(),
      onChange: (res) {
        setState(() {
          selectItem2 = res;
        });
      },
    );
  }

  _onPress3() {
    Map? v;
    try {
      v = selectItem3[selectItem3.length - 1];
    } catch (e) {
      v = {};
    }

    Selector.of(context).showLevel(
      // titles: ["第一列", "第二列", "第三列"],
      data: treeData,
      depth: 3,
      value: v,
      onChange: (res) {
        setState(() {
          selectItem3 = res;
        });
      },
    );
  }

  _onPress4() {
    Selector.of(context).showTree(
      data: treeData,
      onChange: (res) {
        print(res);
        print(res is Map);
        setState(() {
          selectItem4 = res;
        });
      },
      value: selectItem4?['value'],
      // value: 1,
    );
  }

  _onPressYear() {
    Selector.of(context).showYear((v) {
      setState(() {
        year = v;
      });
    }, defaultValue: year);
  }

  _onPressMonth() {
    Selector.of(context).showMonth((v) {
      setState(() {
        ym = v;
      });
    }, defaultValue: ym);
  }

  _onPressDate() {
    Selector.of(context).showDate((v) {
      setState(() {
        ymd = v;
      });
    }, defaultValue: ymd);
  }

  _onPressMinute() {
    Selector.of(context).showMinute((v) {
      setState(() {
        hm = v;
      });
    }, defaultValue: hm);
  }

  _onPressCity() {
    Selector.of(context).showCities((v) {
      setState(() {
        city = v;
      });
    }, defaultValue: city?[2]);
  }
}
