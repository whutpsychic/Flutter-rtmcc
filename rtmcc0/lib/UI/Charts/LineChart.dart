// 默认Y轴最大值是传入值里面最大的那个并且四舍五入至【50，100】
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import './config.dart';

class MyLineChart extends StatefulWidget {
  // 主数据
  final List<double> data;
  // X轴数据
  final List<String>? xAxis;
  // Y轴最大值
  final double? maxY;

  MyLineChart({required this.data, this.xAxis, this.maxY});

  @override
  State<StatefulWidget> createState() => MyLineChartState();
}

class MyLineChartState extends State<MyLineChart> {
  late List<FlSpot> mainData = [];

  @override
  void initState() {
    super.initState();

    List<double> arr = [];
    for (int i = 0; i < widget.data.length; i++) {
      arr.add(0);
    }
    final items = _generateData(arr);
    // 主数据
    mainData = items;

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        mainData = _generateData(widget.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _maxY = widget.maxY ?? _getMaxY();
    int sn = widget.xAxis != null ? widget.xAxis!.length : 10;
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: [lineChartBarData],
        minX: 0,
        maxX: (sn - 1).toDouble(),
        maxY: _maxY,
        minY: 0,
      ),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  FlTitlesData get titlesData {
    return FlTitlesData(
      show: true,
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      leftTitles: leftTitles,
      bottomTitles: bottomTitles,
    );
  }

  SideTitles get leftTitles {
    double _maxY = widget.maxY ?? _getMaxY();
    return SideTitles(
      showTitles: true,
      margin: 0,
      interval: _maxY / num,
      getTextStyles: (context, value) => const TextStyle(
        color: Color(0xff75729e),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      // getTitles: (double value) {
      //   return "";
      // },
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        margin: 10,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        getTitles: widget.xAxis != null
            ? (double value) {
                List arr = [...widget.xAxis!];
                return arr[value.toInt()];
              }
            : null,
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: true,
        colors: colors,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: true),
        spots: mainData,
      );

  double _getMaxY() {
    double result =
        widget.data.reduce((curr, next) => curr > next ? curr : next);

    int z = (result ~/ 100).toInt();
    int y = (result % 100).toInt();

    if (y < 50)
      return (z * 100 + 50).toDouble();
    else
      return ((z + 1) * 100).toDouble();
  }

  List<FlSpot> _generateData(List<double> dataArr) {
    List<FlSpot> result = [];

    for (int i = 0; i < dataArr.length; i++) {
      result.add(FlSpot((i).toDouble(), dataArr[i]));
    }

    return result;
  }
}
