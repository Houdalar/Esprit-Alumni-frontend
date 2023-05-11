import 'package:flutter/material.dart';

class StatisticsData {
  final String field;
  final int count;
  Color color;

  StatisticsData(
      {required this.field, required this.count, required this.color});

  factory StatisticsData.fromJson(Map<String, dynamic> json) {
    return StatisticsData(
      field: json['field'],
      count: json['count'],
      color: Colors.red.shade900,
    );
  }
}
