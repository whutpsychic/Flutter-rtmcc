import 'package:flutter/material.dart';

class SelectorContainer extends StatefulWidget {
  final Widget child;
  final Function? onChange;
  final double? perHeight;
  final List<String>? titles;
  SelectorContainer(
      {required this.child, this.onChange, this.perHeight, this.titles});

  @override
  State<StatefulWidget> createState() => SelectorContainerState();
}

class SelectorContainerState extends State<SelectorContainer> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _ph = widget.perHeight != null ? widget.perHeight! : (38 / 100);

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: _screenWidth,
            height: _screenHeight * _ph,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 47,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xFFdddddd)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('取消', style: TextStyle(fontSize: 16))),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (widget.onChange != null) widget.onChange!();
                          },
                          child: Text('确定', style: TextStyle(fontSize: 16))),
                    ],
                  ),
                ),
                // titles外置
                widget.titles != null
                    ? Container(
                        width: _screenWidth,
                        height: 24,
                        child: Row(
                          children: widget.titles!
                              .map<Widget>((e) => Container(
                                    width: _screenWidth / widget.titles!.length,
                                    height: 24,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ))
                              .toList(),
                        ),
                      )
                    : Container(),
                Container(
                  width: _screenWidth,
                  height: _screenHeight * _ph -
                      48 -
                      (widget.titles != null ? 24 : 0),
                  child: widget.child,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
