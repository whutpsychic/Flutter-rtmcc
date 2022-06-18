import 'package:flutter/material.dart';

class ShortAnswer extends StatefulWidget {
  final Map body;
  ShortAnswer({Key? key, required this.body}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ShortAnswerState();
}

class ShortAnswerState extends State<ShortAnswer> {
  // 题干
  String _mainQuestion = "";

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 设置渲染(以防在build层反复渲染)
    setState(() {
      _mainQuestion = widget.body['question'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Text(
            "\t\t\t\t$_mainQuestion",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        _renderAnswers(),
      ],
    );
  }

  getValue() {
    return controller.text;
  }

  _renderAnswers() {
    double _sw = MediaQuery.of(context).size.width;
    return Container(
      width: _sw,
      height: 16 * 12,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: TextField(
        controller: controller,
        keyboardAppearance: Brightness.light,
        maxLines: 12,
        decoration: InputDecoration.collapsed(hintText: "请在此作答"),
      ),
    );
  }
}
