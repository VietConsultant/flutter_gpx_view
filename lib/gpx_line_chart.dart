import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpx_view/gpx_chart_model.dart';

class GpxLineChart extends StatefulWidget {
  const GpxLineChart({
    super.key,
    this.onChangePosition,
    required this.elevations,
    required this.gpxSacs,
    required this.gpxSacsY,
    this.showAxis = true,
  });
  final List<GpxPeak> elevations;
  final List<GpxSac> gpxSacs;
  final List<GpxSac> gpxSacsY;
  final Function(double, double)? onChangePosition;
  final bool showAxis;

  @override
  State<GpxLineChart> createState() => _GpxLineChartState();
}

class _GpxLineChartState extends State<GpxLineChart> {
  List<Color> chartColor = [
    const Color(0xFFCD2913),
    const Color(0xFF985E1E),
    const Color(0xFF746624),
  ];

  Color getColorBySacScaleLevel(
    String t,
  ) {
    switch (t) {
      case '1':
        return const Color(0xFF6CADF3);
      case '2':
        return const Color(0xFF1D7BF5);
      case '3':
        return const Color(0xFF3AF637);
      case '4':
        return Colors.yellow;
      case '5':
        return const Color(0xFFF89A35);
      case '6':
        return const Color(0xFFFB3304);
      default:
        return const Color(0xFFD9D9D9);
    }
  }

  String _toolTipTitle(int index) {
    final String elevation = widget.elevations[index].ele.toStringAsFixed(2);
    final int matchedIndex = widget.gpxSacs.indexWhere(
      (element) =>
          int.parse(element.end) >= index && int.parse(element.start) <= index,
    );
    if (matchedIndex != -1) {
      final gpxSac = widget.gpxSacs[matchedIndex];
      return 'Height: $elevation\n'
          'Sac scale: ${gpxSac.t}\n'
          'Via ferrata scale: ${gpxSac.f}\n'
          'Visibility: ${gpxSac.v}\n'
          'Surface: ${gpxSac.s}';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.white,
        gridData: const FlGridData(
          show: true,
        ),
        minY: widget.elevations.map((e) => e.ele).reduce(min),
        maxX: widget.elevations.length.toDouble(),
        maxY: widget.elevations.map((e) => e.ele).reduce(max) + 100,
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 44,
              showTitles: widget.showAxis,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    meta.formattedValue,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 30,
              showTitles: widget.showAxis,
              getTitlesWidget: (value, meta) {
                if (widget.gpxSacsY
                    .where(
                      (element) =>
                          double.parse(element.end) ~/ 100 == value ~/ 100,
                    )
                    .isNotEmpty) {
                  final GpxSac gpxSacY = widget.gpxSacsY.firstWhere(
                    (element) =>
                        double.parse(element.end) ~/ 100 == value ~/ 100,
                  );
                  return Text(
                    '${gpxSacY.dist}km',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  );
                }
                return const Text(
                  '',
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: true,
          touchCallback: (event, response) {
            if (response == null) {
              return;
            }
            if (response.lineBarSpots == null) {
              return;
            }
            final GpxPeak peak =
                widget.elevations[response.lineBarSpots!.first.x.toInt()];
            widget.onChangePosition?.call(peak.lat, peak.lon);
          },
          touchTooltipData: LineTouchTooltipData(
            maxContentWidth: 200,
            getTooltipItems: (touchedSpots) {
              return touchedSpots
                  .map(
                    (e) => LineTooltipItem(
                      _toolTipTitle(
                        e.spotIndex.toInt(),
                      ),
                      Theme.of(context).textTheme.bodyMedium!,
                    ),
                  )
                  .toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: widget.elevations
                .asMap()
                .keys
                .map(
                  (key) => FlSpot(
                    key.toDouble(),
                    double.parse(
                      widget.elevations[key].ele.toStringAsFixed(2),
                    ),
                  ),
                )
                .toList(),
            isCurved: true,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, xPercentage, bar, index) {
                final int matchedIndex = widget.gpxSacs.indexWhere(
                  (element) =>
                      int.parse(element.end) >= spot.x &&
                      int.parse(element.start) <= spot.x,
                );
                return FlDotCrossPainter(
                  color: getColorBySacScaleLevel(
                    widget.gpxSacs[matchedIndex].t,
                  ),
                  size: 3,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: chartColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
