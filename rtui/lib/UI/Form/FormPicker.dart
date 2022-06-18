import 'package:flutter/material.dart';
import './FormItem.dart';
import './style.dart';
import '../SelectView/main.dart';

class FormPicker extends StatefulWidget {
  final Key? key;
  // 标签
  final String label;
  // 数据源
  final List<Map> data;
  // 是否是必选项
  final bool? required;
  // 是否可用
  final bool? enabled;
  // 默认值
  final dynamic defaultValue;
  // 值变化回调
  final void Function(Map v)? onChange;

  FormPicker({
    this.key,
    required this.label,
    required this.data,
    this.required,
    this.enabled,
    this.defaultValue,
    this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormPickerState();
}

class FormPickerState extends State<FormPicker> {
  Map? currItem;
  String? _errText;

  @override
  void initState() {
    super.initState();

    // 设置默认值
    if (widget.defaultValue != null) {
      var it = widget.data
          .where((el) => el['value'] == widget.defaultValue)
          .toList();

      if (it.length > 0)
        setState(() {
          currItem = it[0];
        });
    }
  }

  // 快捷校验，不可为空
  bool _validate() {
    if (currItem == null) {
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

  String? getValue() {
    return currItem?['value'];
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
              Text(currItem?['name'] ?? "",
                  style: _enabled
                      ? FormStyle.textStyle
                      : FormStyle.disabledTextStyle),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
  }

  _showPicker(bool enabled) {
    if (!enabled)
      Selector.of(context).show(
        data: widget.data,
        value: currItem?['value'] ?? widget.defaultValue,
        onChange: (v, i) {
          if (widget.onChange != null) {
            widget.onChange!(v);
          }
          setState(() {
            currItem = v;
          });
        },
      );
  }

  @override
  void dispose() {
    // 及时销毁
    super.dispose();
  }
}
