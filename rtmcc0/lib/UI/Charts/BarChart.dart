// 默认Y轴最大值是传入值里面最大的那个并且四舍五入至【50，100】
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import './config.dart';

class MyBarChart extends StatefulWidget {
  // 主数据
  final List<double> data;
  // X轴数据
  final List<String>? xAxis;
  // Y轴最大值
  final double? maxY;

  MyBarChart({required this.data, this.xAxis, this.maxY});

  @override
  State<StatefulWidget> createState() => MyBarChartState();
}

class MyBarChartState extends State<MyBarChart> {
  late List<BarChartGroupData> showingBarGroups;

  // 当前第几个触摸的柱子
  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    List<double> arr = [];
    for (int i = 0; i < widget.data.length; i++) {
      arr.add(0);
    }
    final items = _generateData(arr);
    // 主数据
    showingBarGroups = items;

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        showingBarGroups = _generateData(widget.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _maxY = widget.maxY ?? _getMaxY();
    return BarChart(
      BarChartData(
        maxY: _maxY,
        // 触摸事件
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey[600],
            getTooltipItem: (_a, _b, _c, _d) =>
                BarTooltipItem("${_c.y}", TextStyle(color: Colors.white)),
          ),
        ),
        // 横纵坐标
        titlesData: FlTitlesData(
          show: true,
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          // 底部
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            margin: 20,
            getTitles: widget.xAxis != null
                ? (double value) {
                    return widget.xAxis![value.toInt()];
                  }
                : null,
          ),
          // 左侧
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            margin: 8,
            reservedSize: 28,
            interval: _maxY / num,
            // getTitles: (value) {
            //   if (value == 0) {
            //     return '1K';
            //   } else if (value == 10) {
            //     return '5K';
            //   } else if (value == 19) {
            //     return '10K';
            //   } else {
            //     return 'df';
            //   }
            // },
          ),
        ),
        // 不显示边界
        borderData: FlBorderData(show: false),
        // 核心数据展示
        barGroups: showingBarGroups,
        // 显示网格
        gridData: FlGridData(show: true),
      ),
    );
  }

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

  List<BarChartGroupData> _generateData(List<double> dataArr) {
    List<BarChartGroupData> result = [];

    for (int i = 0; i < dataArr.length; i++) {
      result.add(BarChartGroupData(barsSpace: 4, x: i, barRods: [
        BarChartRodData(
          y: dataArr[i],
          colors: colors,
          width: width,
        )
      ]));
    }

    return result;
  }
}
