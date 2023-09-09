import 'package:flutter/material.dart';
import 'package:flutter_gpx_view/flutter_gpx_chart.dart';
import 'package:flutter_gpx_view/location_service.dart';
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
  Marker? currentMarker;
  Marker? _currentPositionMarker;
  bool _loading = true;
  bool _showChart = true;
  bool _showSatelliteMap = false;
  LocationService locationService = LocationServiceImpl();
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    loadGpxData();
  }

  void onPanChart(double lat, double lon) {
    setState(() {
      currentMarker = Marker(
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

  void _closeChart() {
    setState(() {
      _showChart = false;
    });
  }

  void _openChart() {
    setState(() {
      _showChart = true;
    });
  }

  void _onTapCurrentLocation() {
    locationService.determinePosition().then((currentPosition) {
      setState(() {
        _currentPositionMarker = Marker(
          point: LatLng(currentPosition.latitude, currentPosition.longitude),
          builder: (_) => const Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: 'Current User Position',
            waitDuration: Duration(seconds: 5),
            child: Icon(
              Icons.location_on,
              color: Colors.red,
            ),
          ),
        );
      });
      _mapController.move(
        LatLng(
          currentPosition.latitude,
          currentPosition.longitude,
        ),
        11,
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
        : Container(
            height: MediaQuery.sizeOf(context).height,
            color: Colors.white,
            child: Stack(
              children: [
                SizedBox(
                  height: _showChart
                      ? MediaQuery.sizeOf(context).height * 0.8
                      : MediaQuery.sizeOf(context).height,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: trackPoints.last,
                      zoom: 10.0,
                      bounds: LatLngBounds.fromPoints(trackPoints),
                      boundsOptions: FitBoundsOptions(
                        padding: widget.boundPadding,
                      ),
                    ),
                    children: [
                      _showSatelliteMap
                          ? TileLayer(
                              wmsOptions: WMSTileLayerOptions(
                                baseUrl: 'https://{s}.s2maps-tiles.eu/wms/?',
                                layers: const ['s2cloudless-2021_3857'],
                              ),
                              subdomains: const [
                                'a',
                                'b',
                                'c',
                                'd',
                                'e',
                                'f',
                                'g',
                                'h'
                              ],
                              userAgentPackageName:
                                  'dev.fleaflet.flutter_map.example',
                            )
                          : TileLayer(
                              urlTemplate:
                                  'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'dev.fleaflet.flutter_map.example',
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
                          if (currentMarker != null) currentMarker!,
                          if (_currentPositionMarker != null)
                            _currentPositionMarker!,
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _showChart = true;
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Center(
                          child: AnimatedCrossFade(
                            firstChild: Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: _showChart
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CloseButton(
                                          onPressed: _closeChart,
                                        ),
                                        Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.25,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: GpxChart(
                                            xml: widget.xml,
                                            onChangePosition: onPanChart,
                                            showTotal: true,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            secondChild: IconButton(
                              onPressed: _openChart,
                              icon: const Icon(
                                Icons.keyboard_arrow_up_rounded,
                              ),
                            ),
                            crossFadeState: _showChart
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  right: 12,
                  top: 24,
                  child: SafeArea(
                    top: true,
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 4),
                                blurRadius: 20,
                                blurStyle: BlurStyle.inner,
                              )
                            ],
                            color: Colors.white,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: _onTapCurrentLocation,
                            icon: const Icon(Icons.gps_fixed),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 4),
                                blurRadius: 20,
                                blurStyle: BlurStyle.inner,
                              )
                            ],
                            color: Colors.white,
                          ),
                          child: IconButton(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                _showSatelliteMap = !_showSatelliteMap;
                              });
                            },
                            icon: const Icon(Icons.layers_sharp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
