import 'package:flutter/material.dart';
import './style.dart';

class FormItem extends StatefulWidget {
  final Key? key;
  final String label;
  final Widget child;
  final bool? isRequired;
  final bool? enabled;
  final String? errText;
  final bool? extend;

  FormItem({
    this.key,
    required this.label,
    required this.child,
    this.isRequired,
    this.enabled,
    this.errText,
    this.extend,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormItemState();
}

class FormItemState extends State<FormItem> {
  @override
  Widget build(BuildContext context) {
    final bool _isRequired =
        widget.isRequired != null && widget.isRequired! ? true : false;
    final bool _isEnabled =
        widget.enabled != null && !widget.enabled! ? false : true;
    final double _screenWidth = MediaQuery.of(context).size.width;
    final bool _extendable =
        widget.extend != null && widget.extend! ? true : false;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label标签
          Row(
            children: [
              _isRequired ? FormStyle.isRequiredStar : Container(),
              Text(widget.label, style: FormStyle.labelStyle)
            ],
          ),
          // 主容器
          Container(
            alignment: Alignment.bottomLeft,
            width: _screenWidth,
            margin: EdgeInsets.only(bottom: 4),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: _extendable ? null : FormStyle.itemHeight,
            decoration: BoxDecoration(
              color: _isEnabled ? null : Colors.grey[300],
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: widget.child,
          ),
          // 错误提示
          Container(
            height: 24,
            child: _renderErrText(),
          ),
        ],
      ),
    );
  }

  _renderErrText() {
    if (widget.errText != null) {
      return Text(widget.errText!, style: FormStyle.errTextStyle);
    }
    return Container();
  }
}
