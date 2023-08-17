class Gpx {
  final double latitute;
  final double longitude;
  final double elevation;
  final double sacScale;
  final double ferrataScale;
  final double distance;
  final String visibility;
  final String surface;

  Gpx({
    required this.latitute,
    required this.longitude,
    required this.elevation,
    required this.sacScale,
    required this.ferrataScale,
    required this.distance,
    required this.visibility,
    required this.surface,
  });
}
