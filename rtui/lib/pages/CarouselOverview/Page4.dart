import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../../UI/Button/main.dart';

const int duration = 600;
const double fontSize = 50.0;

class Page4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Page4> with TickerProviderStateMixin {
  late AnimationController c;
  late Animation<double> textOpacity1;
  late Animation<double> textPosition1;

  late AnimationController c2;
  late Animation<double> textOpacity2;
  late Animation<double> textPosition2;

  late AnimationController c3;
  late Animation<double> btnOpacity;

  @override
  void initState() {
    super.initState();
    c = AnimationController(
        duration: const Duration(milliseconds: duration), vsync: this);

    c2 = AnimationController(
        duration: const Duration(milliseconds: duration), vsync: this);

    c3 = AnimationController(
        duration: const Duration(milliseconds: duration), vsync: this);

    // 字体透明动画
    textOpacity1 = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: c, curve: Curves.easeInExpo))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体位置
    textPosition1 = Tween<double>(begin: 300, end: 200)
        .animate(CurvedAnimation(parent: c, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体透明动画
    textOpacity2 = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: c2, curve: Curves.easeInExpo))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体位置
    textPosition2 = Tween<double>(begin: 400, end: 300)
        .animate(CurvedAnimation(parent: c2, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 按钮透明动画
    btnOpacity = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: c3, curve: Curves.easeInExpo))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    c.forward();

    Future.delayed(Duration(milliseconds: 300), () {
      c2.forward();
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      c3.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _sw = MediaQuery.of(context).size.width;
    double _sh = MediaQuery.of(context).size.height;

    return Container(
      width: _sw,
      height: _sh,
      color: Colors.grey,
      child: Stack(
        children: [
          Positioned(
            top: textPosition1.value,
            left: _sw / 2 - 1.5 * fontSize,
            child: Opacity(
              opacity: textOpacity1.value,
              child: Text(
                "更瑞太",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: textPosition2.value,
            left: _sw / 2 - 1.5 * fontSize,
            child: Opacity(
              opacity: textOpacity2.value,
              child: Text(
                "更智联",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: _sw / 2 - 100,
            child: Opacity(
              opacity: btnOpacity.value,
              child: Button(
                size: Size(200, 40),
                child: Text("开始体验"),
                onPressed: _go,
              ),
            ),
          )
        ],
      ),
    );
  }

  _go() {
    Navigator.of(context).pushReplacementNamed("/all-menu");
  }
}
