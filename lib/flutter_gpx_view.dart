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
    required this.distances,
  });

  final String xml;
  final Color polyColor;
  final Icon markerIcon;
  final double polyStrokeWidth;
  final EdgeInsets boundPadding;
  final List<double> distances;

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
        builder: (_) => Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message: 'Current Chart Position',
          waitDuration: const Duration(seconds: 5),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100,
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _closeChart() {
    setState(() {
      _showChart = false;
      if (overlayEntry != null) {
        overlayEntry?.remove();
      }
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
          builder: (_) => Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: 'Current User Position',
            waitDuration: const Duration(seconds: 5),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade100,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
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
      final tooltipMsg = '${wpt.findElements('name').first.value ?? ''}\n'
          '${wpt.findElements('desc').first.value ?? ''}';
      waypoints.add(
        Marker(
          point: LatLng(lat, lon),
          builder: (_) => tooltipMsg == '\n'
              ? Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: '',
                  waitDuration: const Duration(seconds: 5),
                  child: widget.markerIcon,
                )
              : Tooltip(
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
            color: Colors.white,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: _showChart
                          ? (MediaQuery.sizeOf(context).height * 0.25)
                          : 0,
                    ),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        maxZoom: 18,
                        center: trackPoints.last,
                        zoom: 10,
                        rotationWinGestures: MultiFingerGesture.none,
                        interactiveFlags:
                            InteractiveFlag.pinchZoom | InteractiveFlag.drag,
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
                                fallbackUrl:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              )
                            : TileLayer(
                                urlTemplate:
                                    'https://maps.refuges.info/hiking/{z}/{x}/{y}.png',
                                userAgentPackageName:
                                    'dev.fleaflet.flutter_map.example',
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
                    child: AnimatedSize(
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 500),
                      clipBehavior: Clip.none,
                      reverseDuration: const Duration(milliseconds: 500),
                      alignment: Alignment.bottomCenter,
                      child: _showChart
                          ? Container(
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CloseButton(
                                      onPressed: _closeChart,
                                    ),
                                    Container(
                                      clipBehavior: Clip.none,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.25,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: GpxChart(
                                        distances: widget.distances,
                                        xml: widget.xml,
                                        onChangePosition: onPanChart,
                                        showTotal: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: _openChart,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                      ),
                                    ),
                                    const Text(
                                      'Show Elevation Profile',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
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
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: _showChart
                //       ? SafeArea(
                //           child: Container(
                //             width: MediaQuery.sizeOf(context).width,
                //             height: MediaQuery.sizeOf(context).height * 0.25,
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 12,
                //             ),
                //             child: GpxChart(
                //               distances: widget.distances,
                //               xml: widget.xml,
                //               onChangePosition: onPanChart,
                //               showTotal: true,
                //             ),
                //           ),
                //         )
                //       : const SizedBox.shrink(),
                // ),
              ],
            ),
          );
  }
}
