import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Page1> with TickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  late AnimationController controller;
  late AnimationController controller2;

  @override
  void initState() {
    super.initState();

    const duration = 800;

    const howToIn = Curves.easeInCubic;

    // 《轻便》动画控制器
    controller = AnimationController(
        duration: const Duration(milliseconds: duration), vsync: this);

    // 《高效》动画控制器
    controller2 = AnimationController(
        duration: const Duration(milliseconds: duration), vsync: this);

    // 字体位移动画
    animation = Tween<double>(begin: 0, end: 50)
        .animate(CurvedAnimation(parent: controller, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });
    // 字体透明动画
    animation2 = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    // 字体位移动画
    animation3 = Tween<double>(begin: 0, end: 50)
        .animate(CurvedAnimation(parent: controller2, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });
    // 字体透明动画
    animation4 = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: controller2, curve: howToIn))
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });

    Future.delayed(Duration(milliseconds: 500), () {
      controller2.forward();
    });

    // 飞出渐进字
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double _sw = MediaQuery.of(context).size.width;
    double _sh = MediaQuery.of(context).size.height;

    return Container(
      width: _sw,
      height: _sh,
      color: Colors.green,
      child: Stack(
        children: [
          Positioned(
            top: 200,
            left: animation.value,
            child: Opacity(
              opacity: animation2.value,
              child: Text(
                "轻便",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            right: animation3.value,
            child: Opacity(
              opacity: animation4.value,
              child: Text(
                "高效",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
