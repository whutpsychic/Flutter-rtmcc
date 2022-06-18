import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import '../../UI/List/main.dart';

class ListItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<ListItems> with MyPage {
  bool _launched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    const double iconSize = 22;
    const Color iconColor = Colors.white;
    return MyScaffold(
      title: "列表",
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            width: _screenWidth,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                ListGroup(
                  title: "一般列表项",
                  children: [
                    ListItem(title: "Item1"),
                    ListItem(title: "Item2", extra: ListItem.badge(1)),
                    ListItem(title: "Item3", extra: ListItem.info('额外信息'))
                  ],
                ),
                ListGroup(
                  title: "滑块操作列表项",
                  children: [
                    ListItemSwitch(title: "Item1"),
                    ListItemSwitch(
                      leader: ListItem.icon(Icon(
                        Icons.wifi,
                        size: iconSize,
                        color: iconColor,
                      )),
                      title: "Item2",
                      onChange: (v) {
                        setState(() {
                          _launched = v;
                        });
                      },
                      extra: ListItem.info(_launched ? "开启" : "关闭"),
                    )
                  ],
                ),
                ListGroup(
                  title: "箭头列表项",
                  children: [
                    ListItem(title: "Item1", arrow: true),
                    ListItem(
                        title: "Item2", extra: ListItem.badge(1), arrow: true),
                    ListItem(
                        title: "Item3",
                        extra: ListItem.info('额外信息'),
                        arrow: true)
                  ],
                ),
                ListGroup(
                  title: "带图标的列表项",
                  children: [
                    ListItem(
                        leader: ListItem.icon(Icon(
                          Icons.ac_unit,
                          size: iconSize,
                          color: iconColor,
                        )),
                        title: "Item1",
                        arrow: true),
                    ListItem(
                      leader: ListItem.icon(
                          Icon(
                            Icons.wifi,
                            size: iconSize,
                            color: iconColor,
                          ),
                          Colors.red),
                      title: "Item2",
                      arrow: true,
                      extra: ListItem.badge(1),
                    ),
                    ListItem(
                      leader: ListItem.icon(
                          Icon(
                            Icons.flight,
                            size: iconSize,
                            color: iconColor,
                          ),
                          Colors.pink),
                      title: "Item3",
                      arrow: true,
                      extra: ListItem.info('额外信息'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
