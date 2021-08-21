import 'package:flutter/material.dart' hide YearPicker, MonthPicker;
import 'package:flutter/cupertino.dart';
import './SelectorContainer.dart';
import './LevelPicker.dart';
import './TreePicker.dart';
import './YearPicker.dart';
import './MonthPicker.dart';
import './DatePicker.dart';
import './MinutePicker.dart';
import './CityPicker/main.dart';

class Selector {
  final BuildContext context;
  Selector(this.context);

  static const double itemHeight = 45;

  static of(context) {
    return Selector(context);
  }

  // 将树形数据平铺(并插入level属性备用)
  // 添加treeSelfIdentify/treeParentIdentify属性以标明亲子关系
  // 平铺后的数据不含有children属性
  // 不修改数据源
  // 输出格式[
  // {},{},{},{},{},{},{},{},{},{},{},
  // ]
  // 要求树形数据基本单位必须至少包含以下属性
  // name,value
  // 选含属性
  // children
  static List<Map> extendData(List<Map> data) {
    List<Map> _result = [];

    int _level = 1;

    looper(List<Map> oa, int l, [String? pid]) {
      int index = 1;
      oa.forEach((el) {
        // 标记自身id
        String treeSelfIdentify = "${pid ?? "tid"}-${l}_$index";
        index++;

        Map telement = {
          "name": el['name'],
          "value": el['value'],
          "level": l,
          "treeSelfIdentify": treeSelfIdentify
        };
        // 如果有来自上层的parentId，继承之
        if (pid != null) telement['treeParentIdentify'] = pid;
        _result.add(telement);
        if (el.containsKey("children") && el['children'] != null) {
          assert(el['children'] is List);
          looper(el['children'], l + 1, treeSelfIdentify);
        }
      });
    }

    looper(data, _level);

    return _result;
  }

  // 将平铺的数据转化为按照level属性分组的二维数组
  static List<List<Map>> divideIt(List<Map> data, int dp) {
    int _level = 1;
    List<List<Map>> _result = [];

    for (int i = 0; i < dp; i++) {
      List<Map> el = data.where((e) => e['level'] == _level).toList();
      _result.add(el);
      _level++;
    }

    return _result;
  }

  // 二维数组,根据最底层Map的value对象找出所有等级的相关项(级联选择器使用)
  static List<Map?> lookBack(Map? self, List<List<Map>> arr) {
    List<Map?> result = [];
    int D = arr.length;
    Map om = self ?? {};
    int i = D - 1;
    for (; i >= 0; i--) {
      Map? target;

      try {
        target = arr[i]
            .where((element) => element['value'] == om['value'])
            .toList()[0];
      } catch (err) {
        target = null;
      }
      try {
        if (i - 1 >= 0)
          om = arr[i - 1]
              .where((element) =>
                  element['treeSelfIdentify'] == om['treeParentIdentify'])
              .toList()[0];
      } catch (err) {
        om = {};
      }
      result.insert(0, target);
    }

    return result;
  }

  // ----------------------------------------------------------

  // 单选视图
  void show({
    required List<Map> data,
    List<String>? titles,
    Function? onChange,
    dynamic value,
  }) {
    int po = data.indexWhere((element) => element['value'] == value);
    int i = (po == -1 ? 0 : po);
    Map it = data[i];
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        titles: titles,
        onChange: () {
          onChange!(it, i);
        },
        child: CupertinoPicker(
          itemExtent: itemHeight,
          scrollController: FixedExtentScrollController(initialItem: i),
          onSelectedItemChanged: (i) {
            it = data[i];
            i = i;
          },
          children: data
              .map<Widget>(
                (el) => Container(
                  alignment: Alignment.center,
                  height: itemHeight,
                  child: Text(
                    el['name'] ?? "",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // 多列选择视图(认为不超过3列，超过3列请分开选择)
  void showMulti({
    required List<List<Map>> data,
    List<String>? titles,
    Function? onChange,
    List? value,
  }) {
    assert(data.length <= 3);
    double _screenWidth = MediaQuery.of(context).size.width;
    List<List> result = [];
    List _value =
        value != null && value.length > 0 ? value : [null, null, null];
    data.forEach((el) {
      int num = data.indexWhere((element) => element == el);
      int po = el.indexWhere((element) => element['value'] == _value[num]);
      int i = (po == -1 ? 0 : po);
      Map it = el[i];
      result.add([it, i]);
    });
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        titles: titles,
        onChange: () {
          List<Map> _result = [];
          _result = result.map<Map>((e) => e[0]).toList();
          onChange!(_result);
        },
        child: Row(
          children: data.map<Widget>(
            (e) {
              int j = data.indexWhere((element) => element == e);
              j = j == -1 ? 0 : j;
              return Container(
                width: _screenWidth / data.length,
                child: CupertinoPicker(
                  itemExtent: itemHeight,
                  scrollController:
                      FixedExtentScrollController(initialItem: result[j][1]),
                  onSelectedItemChanged: (i) {
                    result[j][0] = e[i];
                    result[j][1] = i;
                  },
                  children: e
                      .map<Widget>((el) => Container(
                            alignment: Alignment.center,
                            height: itemHeight,
                            child: Text(
                              el['name'] ?? "",
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  // 级联选择视图(建议不超过3列，超过3列请考虑使用树形选择器)
  // 不建议在底层节点设置空值，否则将无法设置默认值
  void showLevel({
    required List<Map> data,
    required int depth,
    List<String>? titles,
    Function? onChange,
    Map? value,
  }) {
    int _depth = (depth > 5 ? 5 : depth);

    GlobalKey<LevelSelectorState> _key = GlobalKey();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        titles: titles,
        onChange: () {
          List<Map> vArr = _key.currentState!.getValueArr(_depth);
          onChange!(vArr);
        },
        child: LevelSelector(
          key: _key,
          data: data,
          depth: _depth,
          value: value,
        ),
      ),
    );
  }

  // 树形选择器视图
  void showTree({required List<Map> data, Function? onChange, dynamic value}) {
    GlobalKey<TreeSelectorState> k = GlobalKey();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        perHeight: 80 / 100,
        onChange: () {
          var v = k.currentState?.getValue();
          if (onChange != null) onChange(v?.dataSource);
        },
        child: TreeSelector(key: k, data: data, value: value),
      ),
    );
  }

  // 年份选择器
  void showYear(Function? onChange, {int? defaultValue}) {
    GlobalKey<YearPickerState> ak = GlobalKey();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        onChange: () {
          int v = ak.currentState?.getValue();
          if (onChange != null) onChange(v);
        },
        child: YearPicker(key: ak, defaultValue: defaultValue),
      ),
    );
  }

  // 月份选择器
  void showMonth(Function? onChange, {List<int>? defaultValue}) {
    GlobalKey<MonthPickerState> ak = GlobalKey();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        onChange: () {
          List<int> v = ak.currentState?.getValue();
          if (onChange != null) onChange(v);
        },
        child: MonthPicker(key: ak, defaultValue: defaultValue),
      ),
    );
  }

  // 日期选择器
  void showDate(Function? onChange, {List<int>? defaultValue}) {
    GlobalKey<DatePickerState> ak = GlobalKey();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        onChange: () {
          List<int> v = ak.currentState?.getValue();
          if (onChange != null) onChange(v);
        },
        child: DatePicker(key: ak, defaultValue: defaultValue),
      ),
    );
  }

  // 时分选择器
  void showMinute(Function? onChange, {List<int>? defaultValue}) {
    GlobalKey<MinutePickerState> ak = GlobalKey();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        onChange: () {
          List<int> v = ak.currentState?.getValue();
          if (onChange != null) onChange(v);
        },
        child: MinutePicker(key: ak, defaultValue: defaultValue),
      ),
    );
  }

  // 省市区选择器
  void showCities(Function? onChange, {dynamic defaultValue}) {
    GlobalKey<CityPickerState> ak = GlobalKey();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SelectorContainer(
        onChange: () {
          List v = ak.currentState?.getValue();
          if (onChange != null) onChange(v);
        },
        child: CityPicker(key: ak, defaultValue: defaultValue),
      ),
    );
  }
}
