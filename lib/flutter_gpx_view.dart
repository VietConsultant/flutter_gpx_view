import 'package:flutter/material.dart';
import 'package:flutter_gpx_view/flutter_gpx_chart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xml/xml.dart' as xml;

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
  State<GpxView> createState() => _GpxViewState();
}

class _GpxViewState extends State<GpxView> {
  late List<LatLng> trackPoints;
  late List<Marker> waypoints;
  Marker? currentMarket;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadGpxData();
  }

  void onPanChart(double lat, double lon) {
    setState(() {
      currentMarket = Marker(
        point: LatLng(lat, lon),
        builder: (_) => const Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message: 'Current Chart Position',
          waitDuration: Duration(seconds: 5),
          child: Icon(
            Icons.location_on,
            color: Colors.green,
          ),
        ),
      );
    });
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
      final tooltipMsg = '${wpt.findElements('name').first.value}\n'
          '${wpt.findElements('desc').first.value}';
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
        : Column(
            children: [
              Expanded(
                flex: 2,
                child: FlutterMap(
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
                      urlTemplate:
                          'https://tile.opentopomap.org/{z}/{x}/{y}.png',
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
                      markers: [
                        ...waypoints,
                        if (currentMarket != null) currentMarket!,
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: GpxChart(
                    xml: widget.xml,
                    onChangePosition: onPanChart,
                  ),
                ),
              ),
            ],
          );
  }
}
