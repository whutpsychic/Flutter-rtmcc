import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import './UI/Photo/main.dart';

import './allPages.dart';
import './core/Util/main.dart';
import './config.dart';

void main() {
  runApp(MyApp());

  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
    if (r <= 20 && !AppConfig.debug) return "/carousel-overview";
    return "/all-menu";
  }

  // 此app为强制竖屏，如遇需要横屏的页面，则需手动操作

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[routeObserver],
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
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/pv':
              return PageTransition(
                child: PhotoViewer(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: Duration(milliseconds: 400),
              );
            default:
              return null;
          }
        },
        initialRoute: _generateDefaultRoute(),
        routes: {
          // '/pv': (context) => PhotoViewer2(),
          // --------------- common ---------------
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
          // --------------- v1.2.0 ---------------
          '/scanning': (context) => Scanning(),
          '/scan-result': (context) => ScanResult(),
          '/photo-view': (context) => PhotoView(),
          '/album': (context) => Album(),
          '/video': (context) => VideoPage(),
        },
      ),
    );
  }
}
