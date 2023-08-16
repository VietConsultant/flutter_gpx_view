library flutter_gpx_view;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
class GpxView extends StatefulWidget {
  const GpxView({
    super.key,
    required this.xml,
    this.polyColor = Colors.blueAccent,
    this.markerIcon = const Icon(
      Icons.location_on,
      color: Colors.red,
    ),
    this.polyStrokeWidth = 4.0,
    this.boundPadding = const EdgeInsets.all(20.0),
  });

  final String xml;
  final Color polyColor;
  final Icon markerIcon;
  final double polyStrokeWidth;
  final EdgeInsets boundPadding;

  @override
  State<GpxView> createState() => _GpxMapState();
}

class _GpxMapState extends State<GpxView> {
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
      final tooltipMsg = '${wpt.findElements('name').first.text}\n'
          '${wpt.findElements('desc').first.text}';
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
        : FlutterMap(
            options: MapOptions(
              center: trackPoints.first,
              zoom: 10.0,
              bounds: LatLngBounds.fromPoints(trackPoints),
              boundsOptions: FitBoundsOptions(
                padding: widget.boundPadding,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
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
                markers: waypoints,
              ),
            ],
          );
  }
}
