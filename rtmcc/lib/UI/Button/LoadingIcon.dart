import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import './Button.dart';

const double iconSize = Button.defaultIconSize;

class LoadingIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<LoadingIcon>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 6.28).animate(controller);
    // ..addListener(() {
    //   setState(() {
    //     // The state that has changed here is the animation object’s value.
    //   });
    // });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: controller,
      child: Container(
        child: Icon(Icons.refresh_outlined, size: iconSize),
      ),
    );
  }
}
