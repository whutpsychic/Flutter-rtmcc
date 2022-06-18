import 'package:flutter/material.dart';
import 'package:rtmcc/core/MyPage/MyScaffold.dart';
import '../../UI/Charts/main.dart';

class BarChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChart> {
  final List<double> barData = [10, 20, 30, 48, 72, 15, 33];
  final List<String> xAxisData = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "柱状图",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: MyBarChart(
          data: barData,
          xAxis: xAxisData,
        ),
      ),
    );
  }
}
