import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

const int duration = 800;
const Curve howToIn = Curves.easeInCubic;
const double targetFontSize = 30.0;

class Page3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Page3> with TickerProviderStateMixin {
  late AnimationController c;
  late Animation<double> textOpacity;
  late Animation<double> textSize;
  late Animation<double> textRotate;

  late AnimationController c2;
  late Animation<double> textOpacity2;
  late Animation<double> textSize2;
  late Animation<double> textRotate2;

  @override
  void initState() {
    super.initState();
    c = AnimationController(
        duration: const Duration(milliseconds: duration), vsync: this);

    c2 = AnimationController(
        duration: const Duration(milliseconds: duration), vsync: this);

    // 字体透明动画
    textOpacity = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: c, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体大小
    textSize = Tween<double>(begin: 100, end: targetFontSize)
        .animate(CurvedAnimation(parent: c, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体旋转角度
    textRotate = Tween<double>(begin: 0, end: 1.9)
        .animate(CurvedAnimation(parent: c, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体透明动画
    textOpacity2 = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: c2, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体大小
    textSize2 = Tween<double>(begin: 100, end: targetFontSize)
        .animate(CurvedAnimation(parent: c2, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体旋转角度
    textRotate2 = Tween<double>(begin: 0, end: 2.1)
        .animate(CurvedAnimation(parent: c2, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    c.forward();

    Future.delayed(Duration(milliseconds: 300), () {
      c2.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _sw = MediaQuery.of(context).size.width;
    double _sh = MediaQuery.of(context).size.height;

    return Container(
      width: _sw,
      height: _sh,
      color: Colors.yellow[700],
      child: Stack(
        children: [
          Positioned(
            top: 200,
            left: _sw / 2 - textSize.value,
            child: Opacity(
                opacity: textOpacity.value,
                child: RotationTransition(
                  turns: textRotate,
                  child: Text("时尚", style: TextStyle(fontSize: textSize.value)),
                )),
          ),
          Positioned(
            top: 400,
            left: _sw / 2 - textSize2.value,
            child: Opacity(
                opacity: textOpacity2.value,
                child: RotationTransition(
                  turns: textRotate2,
                  child:
                      Text("潮流", style: TextStyle(fontSize: textSize2.value)),
                )),
          ),
        ],
      ),
    );
  }
}
