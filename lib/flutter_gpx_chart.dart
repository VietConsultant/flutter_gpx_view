library flutter_gpx_view;

import 'package:flutter/material.dart';
import 'package:flutter_gpx_view/gpx_chart_model.dart';
import 'package:flutter_gpx_view/gpx_line_chart.dart';
import 'package:flutter_gpx_view/gpx_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:xml/xml.dart' as xml;

class GpxChart extends StatefulWidget {
  const GpxChart({
    super.key,
    required this.xml,
    this.onChangePosition,
    this.showTotal = false,
  });

  final String xml;
  final Function(double, double)? onChangePosition;
  final bool showTotal;

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
  bool overlayShowed = false;
  OverlayEntry? overlayEntry;
  Map<String, double> total = {};

  Map<String, String> totalTooltips = {
    '1':
        'Trail: Trail well cleared<br/> Terrain: Area flat or slightly sloped, no fall hazard',
    '2':
        'Trail: Trail with continuous line and balanced ascent<br/>Terrain: Partially steep, fall hazard possible.<br/><strong>Requirements:</strong><br/><ul><li>Hiking shoes recommended</li><li>Some sure footedness</li></ul>',
    '3':
        'Trail: Exposed sites may be secured with ropes or chains, possible need to use hands for balance<br/>Terrain: Partly exposed sites with fall hazard, scree, pathless jagged rocks<br/><strong>Requirements:</strong><br/><ul><li>Well sure-footed</li><li>Good hiking shoes</li><li>Basic alpine experience</li></ul>',
    '4':
        'Trail: Sometimes need for hand use to get ahead<br/>Terrain: Quite exposed, precarious grassy acclivities, jagged rocks, facile snow-free glaciers<br/><strong>Requirements:</strong><br/><ul><li>Familiarity with exposed terrain</li><li>Solid trekking boots</li><li>Some ability for terrain assessment</li><li>Alpine experience</li></ul>',
    '5':
        'Trail: Single plainly climbing up to second grade<br/>Terrain: Exposed, demanding terrain, jagged rocks, few dangerous glacier and névé<br/><strong>Requirements:</strong><br/><ul><li>Mountaineering boots</li><li>Reliable assessment of terrain</li><li>Profound alpine experience</li><li>Elementary knowledge of handling with ice axe and rope</li></ul>',
    '6':
        'Trail: Climbing up to second grade<br/>Terrain: Often very exposed, precarious jagged rocks, glacier with danger to slip and fall<br/><strong>Requirements:</strong><br/><ul><li>Mature alpine experience</li><li>Familiarity with the handling of technical alpine equipment</li></ul>',
  };

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
      total[gpxSacs[i].t] = (total[gpxSacs[i].t] ?? 0) +
          double.parse(
            gpxSacs[i].dist,
          );
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

  void _showOverlay(BuildContext context, {required String text}) async {
    final OverlayState overlayState = Overlay.of(context);
    if (overlayShowed) {
      overlayEntry?.remove();
    }
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: 12,
          bottom: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                ),
                width: MediaQuery.sizeOf(context).width - 24,
                padding: const EdgeInsets.all(8),
                child: HtmlWidget(
                  totalTooltips[text] ?? '',
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry!);
    overlayShowed = true;
    await Future.delayed(
      const Duration(seconds: 3),
    )
        // removing overlay entry after stipulated time.
        .whenComplete(
      () => (overlayShowed)
          ? {
              overlayEntry!.remove(),
              overlayShowed = false,
            }
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (widget.showTotal)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GpxLineChart(
                      elevations: elevations,
                      gpxSacs: gpxSacs,
                      gpxSacsY: gpxSacsY,
                      onChangePosition: widget.onChangePosition,
                    ),
                  ),
                  if (widget.showTotal)
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            ...total.keys.map(
                              (e) => InkWell(
                                onTap: () => _showOverlay(context, text: e),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 2,
                                  ),
                                  margin: const EdgeInsets.only(
                                    bottom: 8,
                                    right: 4,
                                    left: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    color: getColorBySacScaleLevel(e),
                                  ),
                                  child: Text(
                                    '${(total[e] ?? 0) / 1000}km',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              )
            : GpxLineChart(
                elevations: elevations,
                gpxSacs: gpxSacs,
                gpxSacsY: gpxSacsY,
                onChangePosition: widget.onChangePosition,
                showAxis: widget.showTotal,
              );
  }
}
