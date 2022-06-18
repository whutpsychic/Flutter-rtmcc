import 'dart:math';
import 'package:flutter/material.dart';
import './allPages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // 有5分之一的概率会随到概览跑马灯页面
  String _generateDefaultRoute() {
    int r = Random().nextInt(100);
    if (r <= 20) return "/carousel-overview";
    return "/all-menu";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: _generateDefaultRoute(),
        routes: {
          '/carousel-overview': (context) => CarouselOverview(),
          '/all-menu': (context) => AllMenu(),
          '/buttons': (context) => Buttons(),
          '/toasts': (context) => Toasts(),
          '/dialogs': (context) => Dialogs(),
          '/actionsheets': (context) => ActionSheets(),
          '/list-items': (context) => ListItems(),
          '/select-views': (context) => SelectViews(),
          '/form-items': (context) => FormItems(),
          '/collapse-items': (context) => CollapseItems(),
          '/carousel': (context) => CarouselPage(),
          '/pull-to-refresh': (context) => PullToRefreshPage(),
          '/all-charts': (context) => Charts(),
          '/bar-chart': (context) => BarChart(),
          '/line-chart': (context) => LineChart(),
          '/pie-chart': (context) => PieChart(),
        },
      ),
    );
  }
}
