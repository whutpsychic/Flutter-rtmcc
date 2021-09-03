import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dialog {
  final BuildContext context;
  Dialog(this.context);

  static of(context) {
    return Dialog(context);
  }

  void toast(String info) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    showCupertinoDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          width: _screenWidth,
          height: _screenHeight,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              info,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        );
      },
    );
  }

  void alert(String title, String content, [Function? fun1]) {
    Function f1 = fun1 ?? () {};
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Container(
              child: Text(content),
            ),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  f1();
                },
                child: Text('好'),
              ),
            ],
          );
        });
  }

  void confirm(String title, String content, Function? fun1, [Function? fun2]) {
    Function f1 = fun1 ?? () {};
    Function f2 = fun2 ?? () {};

    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Container(
              child: Text(content),
            ),
            actions: [
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  f2();
                },
                child: Text('不'),
              ),
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  f1();
                },
                child: Text('是的'),
              ),
            ],
          );
        });
  }

  void input(String title, String content, Function? fun1, [Function? fun2]) {
    TextEditingController _controller = TextEditingController();
    Function f1 = fun1 ?? () {};
    Function f2 = fun2 ?? () {};

    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Container(
              child: Column(
                children: [
                  Text(content),
                  Container(
                    // height: 30,
                    child: Material(
                      child: CupertinoTextField(controller: _controller),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  f2();
                },
                child: Text('且慢'),
              ),
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  String str = _controller.value.text;
                  f1(str);
                },
                child: Text('写好了'),
              ),
            ],
          );
        });
  }

  void evaluation([Function()? fun1, Function()? fun2, Function()? fun3]) {
    String title = "您喜欢吗？";
    String content = "如果您觉得这款App好用便捷，并喜欢此款App,请给予客观公正的评价";

    int _score = 0;

    Function() f1 = fun1 ?? () {};
    Function() f2 = fun2 ?? () {};
    Function() f3 = fun3 ?? () {};

    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          print(_score);
          return CupertinoAlertDialog(
              title: Text(title),
              content: Container(
                child: Column(
                  children: [
                    Text(content),
                  ],
                ),
              ),
              actions: [
                Container(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Star(active: _score > 0),
                      Star(active: _score > 1),
                      Star(active: _score > 2),
                      Star(active: _score > 3),
                      Star(active: _score > 4)
                    ],
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    f1();
                  },
                  child: Text('去评价'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    f2();
                  },
                  child: Text('以后再说'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    f3();
                  },
                  child: Text('不，谢谢'),
                ),
              ]);
        });
  }
}

class Star extends StatefulWidget {
  final bool active;
  final Function? onTap;
  Star({required this.active, this.onTap});

  @override
  State<StatefulWidget> createState() => StarState();
}

class StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!();
        print(widget.active);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          widget.active ? Icons.circle : Icons.star_outline,
          color: Color(0xFF389edc),
        ),
      ),
    );
  }
}
