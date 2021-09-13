import 'package:flutter/material.dart';
import 'package:rtmcc/core/MyPage/MyScaffold.dart';
import '../../UI/Charts/main.dart';

class PieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
  List<double> pieData = [240, 230, 52, 89, 500];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "饼图",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: MyPieChart(data: pieData),
      ),
    );
  }
}
