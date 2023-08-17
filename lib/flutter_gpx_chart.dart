library flutter_gpx_view;

import 'package:flutter/material.dart';
import 'package:flutter_gpx_view/gpx_model.dart';
import 'package:xml/xml.dart' as xml;

class GpxChart extends StatefulWidget {
  const GpxChart({
    super.key,
    required this.xml,
  });

  final String xml;

  @override
  State<GpxChart> createState() => _GpxChartState();
}

class _GpxChartState extends State<GpxChart> {
  bool _loading = true;

  late List<Gpx> trackPoints;

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
    final extensions = document.findAllElements('extensions');
    // for each track point
    for (final trkpt in trkpts) {
      final lat = double.parse(trkpt.getAttribute('lat')!);
      final lon = double.parse(trkpt.getAttribute('lon')!);
      final ele = trkpt.findElements('ele').first.text;
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
        : const SizedBox();
  }
}
