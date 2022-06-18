import 'package:flutter/material.dart';
import './FormItem.dart';
import './style.dart';

class FormNumberInput extends StatefulWidget {
  final Key? key;
  // 标签
  final String label;
  // 是否是必填项
  final bool? required;
  // 是否可用
  final bool? enabled;
  // 默认值
  final String? defaultValue;
  // 值变化回调
  final void Function(String v)? onChange;
  // 自定义校验函数
  final bool Function(String v)? validater;
  // 自定义的校验失败文字，仅当validater存在时生效
  final String? vft;

  FormNumberInput({
    this.key,
    required this.label,
    this.required,
    this.enabled,
    this.defaultValue,
    this.onChange,
    this.validater,
    this.vft,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormNumberInputState();
}

class FormNumberInputState extends State<FormNumberInput> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  String? _errText;

  @override
  void initState() {
    super.initState();

    // 设定默认值
    if (widget.defaultValue != null) _controller.text = widget.defaultValue!;

    // 设定值改变函数
    if (widget.onChange != null) {
      _focusNode.addListener(() {
        // 获焦事件
        if (_focusNode.hasFocus) {
        }
        // 失焦事件
        else {
          widget.onChange!(_controller.text);
        }
      });
    }
  }

  // 快捷校验，不可为空
  bool _validate() {
    if (_controller.text == "") {
      error("您必须填写${widget.label}!");
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
      // 如果有自定义的校验函数，则执行自定义校验操作
      if (widget.validater != null) {
        if (!widget.validater!(_controller.text)) {
          error(widget.vft!);
          return false;
        } else {
          validateSuccess();
          return true;
        }
      }
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
    return _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    bool _enabled = widget.enabled != null && !widget.enabled! ? false : true;

    return FormItem(
      label: widget.label,
      isRequired: widget.required,
      errText: _errText,
      enabled: _enabled,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: _enabled,
        onChanged: _onChangeText,
        keyboardType: TextInputType.number,
        keyboardAppearance: Brightness.light,
        style:
            TextStyle(color: _enabled ? Colors.black : FormStyle.disabledColor),
        decoration: InputDecoration(
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  _onChangeText(v) {
    if (_errText != null)
      setState(() {
        _errText = null;
      });
  }

  @override
  void dispose() {
    // 及时销毁
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
