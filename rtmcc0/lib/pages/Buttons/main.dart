import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import './TextButtons.dart';
import './Buttons.dart';
import './OutlinedButtons.dart';
import './IconButtons.dart';
import './LoadingButtons.dart';
import './BlockButtons.dart';

class Buttons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Buttons> with MyPage {
  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return MyScaffold(
      title: "按钮",
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            width: _screenWidth,
            padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -----------------------------------------------
                TitleText("文字按钮"),
                TextButtons(onPress: _onPress, onLongPress: _onLongPress),
                // -----------------------------------------------
                TitleText("带底色的普通按钮"),
                NormalButtons(onPress: _onPress, onLongPress: _onLongPress),
                // -----------------------------------------------
                TitleText("无底色的普通按钮"),
                NormalButtons2(onPress: _onPress, onLongPress: _onLongPress),
                // -----------------------------------------------
                TitleText("带图标的按钮"),
                IconButtons(onPress: _onPress, onLongPress: _onLongPress),
                // -----------------------------------------------
                TitleText("加载中的按钮"),
                LoadingButtons(onPress: _onPress, onLongPress: _onLongPress),
                // -----------------------------------------------
                TitleText("块级按钮"),
                BlockButtons(onPress: _onPress, onLongPress: _onLongPress)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onPress(String info) {
    toast("您点击了$info");
  }

  _onLongPress(String info) {
    toast("您长按了$info");
  }
}

class TitleText extends StatelessWidget {
  final String? title;
  TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    // 文字分割标题样式
    TextStyle font_title_style =
        TextStyle(fontSize: 14, color: Colors.grey[600]);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Text(title ?? "", style: font_title_style),
    );
  }
}
