import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpx_view/gpx_chart_model.dart';
import 'package:intl/intl.dart';

class GpxLineChart extends StatefulWidget {
  const GpxLineChart({
    super.key,
    this.onChangePosition,
    required this.elevations,
    required this.gpxSacs,
    required this.gpxSacsY,
    this.showAxis = true,
    required this.distances,
  });
  final List<GpxPeak> elevations;
  final List<GpxSac> gpxSacs;
  final List<GpxSac> gpxSacsY;
  final Function(double, double)? onChangePosition;
  final bool showAxis;
  final List<double> distances;

  @override
  State<GpxLineChart> createState() => _GpxLineChartState();
}

class _GpxLineChartState extends State<GpxLineChart> {
  List<Color> chartColor = [
    const Color(0xFFCD2913),
    const Color(0xFF985E1E),
    const Color(0xFF746624),
  ];

  bool showTooltipOnLeft = false;
  final formatter = NumberFormat.decimalPatternDigits();

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
    showTooltipOnLeft = index >= widget.elevations.length * 0.75;

    final String elevation = formatter.format(
      double.parse(widget.elevations[index].ele.toStringAsFixed(0)),
    );
    final int matchedIndex = widget.gpxSacs.indexWhere(
      (element) =>
          int.parse(element.end) >= index && int.parse(element.start) <= index,
    );
    if (matchedIndex != -1) {
      final gpxSac = widget.gpxSacs[matchedIndex];
      return 'Height: ${elevation}m\n'
          'SAC scale: T${gpxSac.t}\n'
          'V. Ferrata: ${gpxSac.f}\n'
          'Vis: ${gpxSac.v} / Surface: ${gpxSac.s}';
    } else {
      return '';
    }
  }

  String _getDistanceTitle(double distance) {
    final RegExp regExp = RegExp(r'([.]*0)(?!.*\d)');
    return '${distance.toStringAsFixed(1).replaceAll(regExp, '')}km';
  }

  @override
  Widget build(BuildContext context) {
    final minY = widget.elevations.map((e) => e.ele).reduce(min);
    final maxY = widget.elevations.map((e) => e.ele).reduce(max) +
        (widget.elevations.map((e) => e.ele).reduce(max) -
                widget.elevations.map((e) => e.ele).reduce(min)) /
            4;
    final maxX = widget.elevations.length.toDouble();
    return LineChart(
      LineChartData(
        backgroundColor: Colors.white,
        gridData: const FlGridData(
          show: true,
        ),
        minY: minY,
        maxX: maxX,
        maxY: maxY,
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
              reservedSize: 54,
              showTitles: widget.showAxis,
              getTitlesWidget: (value, meta) {
                final bool hideLabel = value <= minY || value >= maxY;
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    hideLabel
                        ? ''
                        : '${formatter.format(
                            value.toInt(),
                          )}m',
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
              reservedSize: 50,
              showTitles: widget.showAxis,
              getTitlesWidget: (value, meta) {
                if (value == widget.distances.length) {
                  return const Text('');
                }

                return Transform.rotate(
                  angle: -pi / 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      _getDistanceTitle(widget.distances[value.toInt()]),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
            tooltipBgColor: Colors.grey.shade400,
            tooltipBorder: const BorderSide(color: Colors.black),
            maxContentWidth: 200,
            tooltipHorizontalOffset: showTooltipOnLeft ? -90 : 0,
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            getTooltipItems: (touchedSpots) {
              return touchedSpots
                  .map(
                    (e) => LineTooltipItem(
                      _toolTipTitle(
                        e.spotIndex.toInt(),
                      ),
                      Theme.of(context).textTheme.bodySmall!,
                      textAlign: TextAlign.left,
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
