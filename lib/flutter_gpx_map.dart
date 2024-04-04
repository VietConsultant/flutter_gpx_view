library flutter_gpx_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart' as xml;

/// A widget to display GPX data on a map.
/// The GPX data is passed as a string.
/// The widget uses the [flutter_map](https://pub.dev/packages/flutter_map) package.
/// The map tiles are provided by [OpenTopoMap](https://opentopomap.org).
/// The GPX data is parsed using the [xml](https://pub.dev/packages/xml) package.
/// [xml] is xml String parser for Dart.
/// [polyColor] is the color of the polyline.
/// [markerIcon] is the icon of the markers.
/// [polyStrokeWidth] is the width of the polyline.
/// [boundPadding] is the padding of the map bounds.
class GpxMap extends StatefulWidget {
  const GpxMap({
    super.key,
    required this.xml,
    this.polyColor = Colors.blueAccent,
    this.markerIcon = const Icon(
      Icons.location_on,
      color: Colors.red,
    ),
    this.polyStrokeWidth = 4.0,
    this.boundPadding = const EdgeInsets.all(20.0),
    this.onTapMap,
    this.mapController,
    this.showCredit = true,
  });

  final String xml;
  final Color polyColor;
  final Icon markerIcon;
  final double polyStrokeWidth;
  final EdgeInsets boundPadding;
  final VoidCallback? onTapMap;
  final MapController? mapController;
  final bool showCredit;

  @override
  State<GpxMap> createState() => _GpxMapState();
}

class _GpxMapState extends State<GpxMap> {
  late List<LatLng> trackPoints;
  late List<Marker> waypoints;

  bool _loading = true;

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
    waypoints = [];

    final trkpts = document.findAllElements('trkpt');
    final wpts = document.findAllElements('wpt');

    for (final trkpt in trkpts) {
      final lat = double.parse(trkpt.getAttribute('lat')!);
      final lon = double.parse(trkpt.getAttribute('lon')!);
      trackPoints.add(LatLng(lat, lon));
    }

    for (final wpt in wpts) {
      final lat = double.parse(wpt.getAttribute('lat')!);
      final lon = double.parse(wpt.getAttribute('lon')!);
      final tooltipMsg = '${wpt.findElements('name').first.value ?? ''}\n'
          '${wpt.findElements('desc').first.value ?? ''}';
      waypoints.add(
        Marker(
          point: LatLng(lat, lon),
          builder: (_) => Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: tooltipMsg,
            waitDuration: const Duration(seconds: 5),
            child: widget.markerIcon,
          ),
        ),
      );
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              FlutterMap(
                mapController: widget.mapController,
                options: MapOptions(
                  maxZoom: 18,
                  center: trackPoints.last,
                  zoom: 10,
                  rotationWinGestures: MultiFingerGesture.none,
                  interactiveFlags:
                      InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  enableScrollWheel: false,
                  onTap: (tapPosition, point) {
                    if (widget.onTapMap != null) {
                      widget.onTapMap?.call();
                      return;
                    }
                  },
                  bounds: LatLngBounds.fromPoints(trackPoints),
                  boundsOptions: FitBoundsOptions(
                    padding: widget.boundPadding,
                  ),
                ),
                children: [
                  TileLayer(
                    wmsOptions: WMSTileLayerOptions(
                      baseUrl: 'https://{s}.s2maps-tiles.eu/wms/?',
                      layers: const ['s2cloudless-2021_3857'],
                    ),
                    subdomains: const ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    fallbackUrl:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  TileLayer(
                    urlTemplate:
                        'https://maps.refuges.info/hiking/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    fallbackUrl:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: trackPoints,
                        strokeWidth: widget.polyStrokeWidth,
                        color: widget.polyColor,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [...waypoints],
                  ),
                ],
              ),
              if (widget.showCredit)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 12,
                    ),
                    alignment: Alignment.bottomRight,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: '© ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'OpenStreetMap',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                  Uri.parse(
                                    'https://www.openstreetmap.org/copyright',
                                  ),
                                );
                              },
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' contributors',
                            style: TextStyle(
                              decorationColor: Colors.white,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
  }
}
