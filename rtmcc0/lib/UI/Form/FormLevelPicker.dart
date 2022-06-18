import 'package:flutter/material.dart';
import './FormItem.dart';
import './style.dart';
import '../SelectView/main.dart';

class FormLevelPicker extends StatefulWidget {
  final Key? key;
  // 标签
  final String label;
  // 数据源
  final List<Map> data;
  // 数据结构深度
  final int depth;
  // 是否是必选项
  final bool? required;
  // 是否可用
  final bool? enabled;
  // 默认值
  final dynamic defaultValue;
  // 值变化回调
  final void Function(List<Map> v)? onChange;

  FormLevelPicker({
    this.key,
    required this.label,
    required this.data,
    required this.depth,
    this.required,
    this.enabled,
    this.defaultValue,
    this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormLevelPickerState();
}

class FormLevelPickerState extends State<FormLevelPicker> {
  List<Map>? currItems;
  String? _errText;

  @override
  void initState() {
    super.initState();
    int dp = widget.depth;

    // 根据子值查询并获取父件
    Map _findParentByKid(List<Map> allData, dynamic kidValue) {
      Map oa = allData.where((el) => el['value'] == kidValue).toList()[0];
      String tpid = oa['treeParentIdentify'];
      Map result =
          allData.where((el) => el['treeSelfIdentify'] == tpid).toList()[0];
      return result;
    }

    // 设置默认值
    if (widget.defaultValue != null) {
      List<Map> expandedData = Selector.extendData(widget.data);
      currItems = [];
      dynamic ov = widget.defaultValue;

      List self = expandedData
          .where((el) => el['value'] == widget.defaultValue)
          .toList();

      if (self.length > 0) {
        currItems!.insert(0, self[0]);

        for (int i = 0; i < dp - 1; i++) {
          Map p = _findParentByKid(expandedData, ov);
          currItems!.insert(0, p);
          ov = p['value'];
        }
      }
    }
  }

  // 快捷校验，不可为空
  bool _validate() {
    if (currItems == null) {
      error("您必须选择${widget.label}!");
      return false;
    } else {
      validateSuccess();
      return true;
    }
  }

  // 主校验入口
  bool validate() {
    // 如果有必填项才会继续向下判断
    if (widget.required != null && widget.required!) {
      // 如果没有则只进行非空校验
      return _validate();
    }
    // 默认不校验
    return true;
  }

  void error(String x) {
    setState(() {
      _errText = x;
    });
  }

  void validateSuccess() {
    setState(() {
      _errText = null;
    });
  }

  List? getValue() {
    return currItems?.map((e) => e['value']).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool _enabled = widget.enabled != null && !widget.enabled! ? false : true;

    return GestureDetector(
      onTap: () => _showPicker(!_enabled),
      child: FormItem(
        label: widget.label,
        isRequired: widget.required,
        enabled: _enabled,
        errText: _errText,
        child: Container(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  currItems?.map((el) => el['name']).toList().join(' - ') ?? "",
                  style: _enabled
                      ? FormStyle.textStyle
                      : FormStyle.disabledTextStyle),
              Icon(Icons.menu_open_outlined)
            ],
          ),
        ),
      ),
    );
  }

  _showPicker(bool enabled) {
    if (!enabled)
      Selector.of(context).showLevel(
        data: widget.data,
        depth: widget.depth,
        value: currItems?[currItems!.length - 1] ?? widget.defaultValue,
        onChange: (v) {
          setState(() {
            currItems = v;
          });
          if (widget.onChange != null) widget.onChange!(v);
        },
      );
  }

  @override
  void dispose() {
    // 及时销毁
    super.dispose();
  }
}
