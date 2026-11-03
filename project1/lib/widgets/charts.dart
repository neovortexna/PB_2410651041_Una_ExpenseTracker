import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Grafik garis sederhana untuk kartu "Total Spent" (tanpa package tambahan).
class SpendingLineChart extends StatelessWidget {
  const SpendingLineChart({super.key, required this.values, this.height = 130});

  final List<double> values;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Grafik garis tren pengeluaran',
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(painter: _LinePainter(values)),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter(this.values);

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);
    final range = (maxValue - minValue) == 0 ? 1.0 : (maxValue - minValue);
    const padding = 4.0;

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final dx = size.width * i / (values.length - 1);
      final ratio = (values[i] - minValue) / range;
      final dy = padding + (size.height - 2 * padding) * (1 - ratio);
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }

    final paint = Paint()
      ..color = AppColors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) =>
      oldDelegate.values != values;
}

/// Grafik batang vertikal Senin-Minggu (Weekly Spending).
class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({
    super.key,
    required this.values,
    required this.labels,
    this.highlightIndex,
    this.height = 170,
  });

  final List<double> values;
  final List<String> labels;
  final int? highlightIndex;
  final double height;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce(math.max);
    return Semantics(
      label: 'Grafik batang pengeluaran mingguan',
      child: SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(values.length, (i) {
            final barHeight = (height - 28) * values[i] / maxValue;
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: barHeight,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: i == highlightIndex
                          ? AppColors.blue
                          : AppColors.teal,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    labels[i],
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class DonutSegment {
  const DonutSegment({required this.value, required this.color});

  final double value;
  final Color color;
}

/// Grafik donat kategori pengeluaran (Expense Categories).
class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.segments,
    this.size = 130,
    this.strokeWidth = 26,
  });

  final List<DonutSegment> segments;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Grafik donat kategori pengeluaran',
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _DonutPainter(segments, strokeWidth)),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter(this.segments, this.strokeWidth);

  final List<DonutSegment> segments;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final total = segments.fold<double>(0, (sum, s) => sum + s.value);
    if (total <= 0) return;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    var startAngle = -math.pi / 2;
    for (final segment in segments) {
      final sweep = 2 * math.pi * segment.value / total;
      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.segments != segments ||
      oldDelegate.strokeWidth != strokeWidth;
}
