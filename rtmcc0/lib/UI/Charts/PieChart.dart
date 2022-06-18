import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import './config.dart';

class MyPieChart extends StatefulWidget {
  // 主数据
  final List<double> data;
  final bool? isRing;

  MyPieChart({required this.data, this.isRing});

  @override
  State<StatefulWidget> createState() => MyPieChartState();
}

class MyPieChartState extends State<MyPieChart> {
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isRing = widget.isRing != null && widget.isRing!;
    double ps = _isRing ? pieSize - circleSize : pieSize;
    double cs = _isRing ? circleSize : 0;
    return PieChart(
      PieChartData(
        pieTouchData:
            PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                pieTouchResponse == null ||
                pieTouchResponse.touchedSection == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
          });
        }),
        startDegreeOffset: 180,
        borderData: FlBorderData(show: false),
        centerSpaceRadius: cs,
        sections: showingSections(ps),
      ),
    );
  }

  List<PieChartSectionData> showingSections(ps) {
    return List.generate(
      widget.data.length,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;

        return PieChartSectionData(
          color: colors[i].withOpacity(opacity),
          value: widget.data[i],
          title: '',
          radius: ps,
          titleStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xff044d7c)),
          borderSide: isTouched
              ? BorderSide(color: colors[i].darken(40), width: 6)
              : BorderSide(color: colors[i].withOpacity(0)),
        );
      },
    );
  }
}
