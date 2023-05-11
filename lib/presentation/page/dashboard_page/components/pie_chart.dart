import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const PieChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> chartColors = [
      const Color(0xFF910000),
      const Color(0xFF6B0000),
      const Color(0xFFD32431),
      const Color(0xFFFF3F3D),
      const Color(0xFFFF6B6B),
    ];

    return Column(
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: data.asMap().entries.map((entry) {
              final color = chartColors[entry.key % chartColors.length];
              final value = entry.value;

              return PieChartSectionData(
                color: color,
                value: value['count'].toDouble(),
                title: '${value['count']}',
                radius: 100,
                titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: data.asMap().entries.map((entry) {
            final color = chartColors[entry.key % chartColors.length];
            final value = entry.value;

            return Indicator(color: color, text: value['field']);
          }).toList(),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
