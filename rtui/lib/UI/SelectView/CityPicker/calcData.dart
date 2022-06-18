// 级联选择器视图
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future getCityData() async {
  String _prov = await rootBundle.loadString("json/province.json");
  String _city = await rootBundle.loadString("json/city.json");
  String _area = await rootBundle.loadString("json/area.json");

  List _provO = jsonDecode(_prov).map((el) {
    el['value'] = el['code'];
    if (el['name'] == "北京市") el['city'] = "01";
    if (el['name'] == "天津市") el['city'] = "01";
    if (el['name'] == "重庆市") el['city'] = "01";
    if (el['name'] == "上海市") el['city'] = "01";
    return el;
  }).toList();

  List _cityO = jsonDecode(_city).map((el) {
    el['value'] = el['code'];
    return el;
  }).toList();

  List _areaO = jsonDecode(_area).map((el) {
    el['value'] = el['code'];
    return el;
  }).toList();

  return [_provO, _cityO, _areaO];
}
