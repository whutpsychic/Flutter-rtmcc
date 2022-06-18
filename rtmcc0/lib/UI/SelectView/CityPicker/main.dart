// 城市选择器视图
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import './calcData.dart';

class CityPicker extends StatefulWidget {
  final Key? key;
  final Function? onChange;
  final dynamic defaultValue;

  CityPicker({
    this.key,
    this.onChange,
    this.defaultValue,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CityPickerState();
}

class CityPickerState extends State<CityPicker> {
  List _cityDataSource = [];
  List _areaDataSource = [];

  List _province = [];
  List _city = [];
  List _area = [];

  int currPI = 0;
  int currCI = 0;
  int currAI = 0;

  late FixedExtentScrollController cfesc;
  late FixedExtentScrollController afesc;

  @override
  void initState() {
    super.initState();
    // 滚动控制器
    // cfesc = FixedExtentScrollController();
    // afesc = FixedExtentScrollController();
    getCityData().then((vArr) {
      // 设置数据源
      setState(() {
        _province = vArr[0];
        _cityDataSource = vArr[1];
        _areaDataSource = vArr[2];

        // 设置默认值
        if (widget.defaultValue != null) {
          String _tp = widget.defaultValue['province'];
          String _tc = widget.defaultValue['city'];
          String _t = widget.defaultValue['code'];

          // 根据底层province找到省并滚动到位置
          int pi = vArr[0].indexWhere((el) => el['province'] == _tp);
          currPI = pi;
          // 根据省渲染市
          List cities = vArr[1].where((el) => el['province'] == _tp).toList();
          _city = cities;
          // 根据底层city找到市并滚到位置
          int ci = cities.indexWhere((el) => el['city'] == _tc);
          cfesc = FixedExtentScrollController(initialItem: ci);
          // 根据市渲染区
          List areas = vArr[2]
              .where((el) => el['province'] == _tp && el['city'] == _tc)
              .toList();
          _area = areas;
          // 根据底层区code找到区并滚动到位置
          int ai = areas.indexWhere((el) => el['code'] == _t);
          afesc = FixedExtentScrollController(initialItem: ai);
        }
        // 默认为第一个
        else {
          cfesc = FixedExtentScrollController();
          afesc = FixedExtentScrollController();
          _onChangeProvince(vArr[0][0], 0);
        }
      });
    });
  }

  _onChangeProvince(x, i) {
    List _c =
        _cityDataSource.where((el) => el['province'] == x['province']).toList();
    if (_c.length == 0) {
      _c.add(x);
    }

    setState(() {
      currPI = i;
      _city = _c;
    });
    cfesc.jumpToItem(0);
    _onChangeCity(_c[0], 0);
  }

  _onChangeCity(x, i) {
    List _c = _areaDataSource
        .where(
            (el) => el['province'] == x['province'] && el['city'] == x['city'])
        .toList();
    if (_c.length == 0) {
      _c.add(x);
    }

    setState(() {
      currCI = i;
      _area = _c;
    });
    afesc.jumpToItem(0);
  }

  getValue() {
    return [_province[currPI], _city[currCI], _area[currAI]];
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
            width: _screenWidth / 3,
            child: _province.length > 0
                ? CupertinoPicker(
                    itemExtent: Selector.itemHeight,
                    scrollController:
                        FixedExtentScrollController(initialItem: currPI),
                    onSelectedItemChanged: (i) {
                      // ---------
                      _onChangeProvince(_province[i], i);
                    },
                    children: _province.map<Widget>((el) {
                      return Container(
                        alignment: Alignment.center,
                        height: Selector.itemHeight,
                        child: Text(
                          el['name'] ?? "",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  )
                : null),
        Container(
          width: _screenWidth / 3,
          child: _city.length > 0
              ? CupertinoPicker(
                  itemExtent: Selector.itemHeight,
                  scrollController: cfesc,
                  onSelectedItemChanged: (i) {
                    // ---------
                    _onChangeCity(_city[i], i);
                  },
                  children: _city
                      .map<Widget>((el) => Container(
                            alignment: Alignment.center,
                            height: Selector.itemHeight,
                            child: Text(
                              el['name'] ?? "",
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                      .toList(),
                )
              : null,
        ),
        Container(
          width: _screenWidth / 3,
          child: _area.length > 0
              ? CupertinoPicker(
                  itemExtent: Selector.itemHeight,
                  scrollController: afesc,
                  onSelectedItemChanged: (i) {
                    // ---------
                    setState(() {
                      currAI = i;
                    });
                  },
                  children: _area
                      .map<Widget>((el) => Container(
                            alignment: Alignment.center,
                            height: Selector.itemHeight,
                            child: Text(
                              el['name'] ?? "",
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                      .toList(),
                )
              : null,
        ),
      ],
    );
  }
}
