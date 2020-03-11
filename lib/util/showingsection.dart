import 'package:corona/Models/brief.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

String getpercent(Brief _brief, int term) {
  int total = _brief.confirmed + _brief.recovered + _brief.deaths;
  return (((term / total) * 100).toStringAsFixed(2)).toString() + " %";
}

List<PieChartSectionData> showingSections(Brief _brief) {
  return List.generate(3, (i) {
    final double fontSize = 16;
    final double radius = 50;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: _brief.confirmed.toDouble(),
          title: getpercent(_brief, _brief.confirmed),
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.green,
          value: _brief.recovered.toDouble(),
          title: getpercent(_brief, _brief.recovered),
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: Colors.red,
          value: _brief.deaths.toDouble(),
          title: getpercent(_brief, _brief.deaths),
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );

      default:
        return null;
    }
  });
}
