import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FillInBlank extends StatefulWidget {
  final Map body;
  FillInBlank({Key? key, required this.body}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FillInBlankState();
}

class FillInBlankState extends State<FillInBlank> {
  // 题干
  String _mainQuestion = "";

  int _blanks = 0;

  // 所有空的controller
  List<TextEditingController> cs = [];

  @override
  void initState() {
    super.initState();

    // 设置渲染(以防在build层反复渲染)
    setState(() {
      _mainQuestion = widget.body['question'];
      _blanks = widget.body['blanks'];

      for (int i = 0; i < _blanks; i++) {
        cs.add(TextEditingController());
      }
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
        ..._renderAnswers(),
      ],
    );
  }

  getValue() {
    return cs.map<String?>((e) => e.text).toList();
  }

  _renderAnswers() {
    double _sw = MediaQuery.of(context).size.width;
    List<Widget> result = [];
    for (int i = 0; i < _blanks; i++) {
      result.add(Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Text("（ ${i + 1} ）"),
            Container(
              width: _sw - 80,
              child: TextField(
                keyboardAppearance: Brightness.light,
                controller: cs[i],
              ),
            )
          ],
        ),
      ));
    }
    return result;
  }
}
