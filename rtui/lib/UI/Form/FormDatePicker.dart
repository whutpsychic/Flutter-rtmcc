import 'package:flutter/material.dart';
import './FormItem.dart';
import './style.dart';
import '../SelectView/main.dart';

class FormDatePicker extends StatefulWidget {
  final Key? key;
  // 标签
  final String label;
  // 是否是必选项
  final bool? required;
  // 是否可用
  final bool? enabled;
  // 默认值
  final DateTime? defaultValue;
  // 值变化回调
  final void Function(DateTime v)? onChange;

  FormDatePicker({
    this.key,
    required this.label,
    this.required,
    this.enabled,
    this.defaultValue,
    this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormDatePickerState();
}

class FormDatePickerState extends State<FormDatePicker> {
  DateTime? _currTime;
  String? _errText;

  @override
  void initState() {
    super.initState();

    // 设置默认值
    if (widget.defaultValue != null) {
      setState(() {
        _currTime = widget.defaultValue;
      });
    }
  }

  // 快捷校验，不可为空
  bool _validate() {
    if (_currTime == null) {
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

  DateTime? getValue() {
    return _currTime;
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
                  _currTime != null
                      ? "${_currTime!.year}年${_currTime!.month}月${_currTime!.day}日"
                      : "",
                  style: _enabled
                      ? FormStyle.textStyle
                      : FormStyle.disabledTextStyle),
              Icon(Icons.date_range_outlined)
            ],
          ),
        ),
      ),
    );
  }

  _showPicker(bool enabled) {
    if (!enabled)
      Selector.of(context).showDate(
        (v) {
          if (widget.onChange != null) {
            widget.onChange!(v);
          }
          setState(() {
            _currTime = v;
          });
        },
        defaultValue: _currTime ?? widget.defaultValue,
      );
  }

  @override
  void dispose() {
    // 及时销毁
    super.dispose();
  }
}
