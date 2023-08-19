library flutter_gpx_view;

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpx_view/gpx_chart_model.dart';
import 'package:flutter_gpx_view/gpx_model.dart';
import 'package:xml/xml.dart' as xml;

class GpxChart extends StatefulWidget {
  const GpxChart({
    super.key,
    required this.xml,
    this.onChangePosition,
  });

  final String xml;
  final Function(double, double)? onChangePosition;

  @override
  State<GpxChart> createState() => _GpxChartState();
}

class _GpxChartState extends State<GpxChart> {
  bool _loading = true;

  late List<Gpx> trackPoints;
  List<GpxPeak> elevations = [];
  final List<GpxSac> gpxSacs = [];
  final List<GpxSac> gpxSacsY = [];
  List<GpxPeak> markers = [];

  @override
  void initState() {
    super.initState();
    loadGpxData();
  }

  Future<void> loadGpxData() async {
    if (widget.xml.isEmpty) {
      // show error
      debugPrint('No GPX data found');
      return;
    }
    final document = xml.XmlDocument.parse(widget.xml);

    trackPoints = [];

    final trkpts = document.findAllElements('trkpt');
    final extensions = document.findAllElements('ext:hb');

    GpxStatistics statistics = GpxStatistics();

    for (final ext in extensions) {
      if (ext.childElements.isNotEmpty) {
        for (final extChild in ext.childElements) {
          if (extChild.qualifiedName == 'ext:statistics') {
            final GpxStatistics tmp = GpxStatistics.fromJson(
              extChild.attributes
                  .map((p0) => {p0.name.toString(): p0.value})
                  .toList()
                  .first,
            );
            statistics = GpxStatistics(
              cs1: tmp.cs1.isNotEmpty ? tmp.cs1 : statistics.cs1,
              cs2: tmp.cs2.isNotEmpty ? tmp.cs2 : statistics.cs2,
              cs3: tmp.cs3.isNotEmpty ? tmp.cs3 : statistics.cs3,
              cs4: tmp.cs4.isNotEmpty ? tmp.cs4 : statistics.cs4,
              cs5: tmp.cs5.isNotEmpty ? tmp.cs5 : statistics.cs5,
              cs6: tmp.cs6.isNotEmpty ? tmp.cs6 : statistics.cs6,
              elevationGain: tmp.elevationGain.isNotEmpty
                  ? tmp.elevationGain
                  : statistics.elevationGain,
              elevationLoss: tmp.elevationLoss.isNotEmpty
                  ? tmp.elevationLoss
                  : statistics.elevationLoss,
              dist: tmp.dist.isNotEmpty ? tmp.dist : statistics.dist,
              durationHours: tmp.durationHours.isNotEmpty
                  ? tmp.durationHours
                  : statistics.durationHours,
              minHeight: tmp.minHeight.isNotEmpty
                  ? tmp.minHeight
                  : statistics.minHeight,
              peakHeight: tmp.peakHeight.isNotEmpty
                  ? tmp.peakHeight
                  : statistics.peakHeight,
              peak: tmp.peak.isNotEmpty ? tmp.peak : statistics.peak,
              rating: tmp.rating.isNotEmpty ? tmp.rating : statistics.rating,
            );
          } else if (extChild.qualifiedName == 'ext:sac') {
            final Map<String, dynamic> sac = {};
            for (final attribute in extChild.attributes) {
              sac[attribute.name.toString()] = attribute.value;
            }
            final GpxSac tmp = GpxSac.fromJson(sac);

            gpxSacs.add(tmp);
          }
        }
      }
    }
    markers = statistics.peak;

    for (var i = 1; i < gpxSacs.length; i++) {
      if (i % 7 == 0) {
        debugPrint('$i');
        gpxSacsY.add(gpxSacs[i]);
      }
    }

    // final extensions = document.findAllElements('extensions');
    // for each track point
    for (final trkpt in trkpts) {
      final ele = trkpt.firstElementChild!.nodes.first.value;
      final lat = double.parse(trkpt.getAttribute('lat')!);
      final lon = double.parse(trkpt.getAttribute('lon')!);
      elevations.add(
        GpxPeak(
          lat: lat,
          lon: lon,
          ele: double.parse(ele!),
        ),
      );
    }
    debugPrint(elevations.length.toString());
    setState(() {
      _loading = false;
    });
  }

  String _toolTipTitle(int index) {
    final String elevation = elevations[index].ele.toStringAsFixed(2);
    final int matchedIndex = gpxSacs.indexWhere(
      (element) =>
          int.parse(element.end) >= index && int.parse(element.start) <= index,
    );
    if (matchedIndex != -1) {
      final gpxSac = gpxSacs[matchedIndex];
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
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(
                  show: false,
                ),
                minY: elevations.map((e) => e.ele).reduce(min) - 4,
                maxX: elevations.length.toDouble(),
                maxY: elevations.map((e) => e.ele).reduce(max) + 50,
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                titlesData: const FlTitlesData(
                  topTitles: AxisTitles(),
                  leftTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                  bottomTitles: AxisTitles(),
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchCallback: (event, response) {
                    // debugPrint(
                    //   '${p1?.lineBarSpots?.last.barIndex} ${elevations[p1?.lineBarSpots?.first.x.toInt() ?? 0]}',
                    // );
                    if (response == null) {
                      return;
                    }
                    if (response.lineBarSpots == null) {
                      return;
                    }
                    final GpxPeak peak =
                        elevations[response.lineBarSpots!.first.x.toInt()];
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
                    spots: elevations
                        .asMap()
                        .keys
                        .map(
                          (key) => FlSpot(
                            key.toDouble(),
                            double.parse(
                              elevations[key].ele.toStringAsFixed(2),
                            ),
                          ),
                        )
                        .toList(),
                    isCurved: true,
                    isStrokeCapRound: true,
                    barWidth: 7,
                    color: Colors.lightGreen.shade600,
                    dotData: const FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
