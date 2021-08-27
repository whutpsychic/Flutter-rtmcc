import 'package:flutter/material.dart' hide Form;

class Form extends StatefulWidget {
  final Key? key;
  final List<Widget> children;
  final List<GlobalKey>? keys;
  Form({this.key, required this.children, this.keys}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormState();
}

class FormState extends State<Form> {
  bool validate() {
    // 如果keys存在
    if (widget.keys != null) {
      List arr = [];
      arr = widget.keys!;
      List<bool> res = [];
      arr.forEach((element) {
        res.add(element.currentState.validate());
      });
      return !res.contains(false);
    }
    // 若没设置keys则认为用户不打算进行任何额外操作
    else {
      return true;
    }
  }

  List? getValue() {
    if (widget.keys != null) {
      List arr = [];
      arr = widget.keys!;
      List result = [];
      arr.forEach((element) {
        result.add(element.currentState.getValue());
      });
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: widget.children);
  }
}
