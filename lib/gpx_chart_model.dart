import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'gpx_chart_model.freezed.dart';
part 'gpx_chart_model.g.dart';

@freezed
class GpxChart with _$GpxChart {
  factory GpxChart({
    required GpxStatistics gpxStatistics,
    required GpxSac gpxSac,
  }) = _GpxChart;

  factory GpxChart.fromJson(Map<String, Object?> json) =>
      _$GpxChartFromJson(json);
}

@freezed
class GpxSac with _$GpxSac {
  factory GpxSac({
    @Default('') @JsonKey(name: 'ext:S') String s,
    @Default('') @JsonKey(name: 'ext:end') String end,
    @Default('') @JsonKey(name: 'ext:start') String start,
    @Default('') @JsonKey(name: 'ext:dist') String dist,
    @Default('') @JsonKey(name: 'ext:V') String v,
    @Default('') @JsonKey(name: 'ext:T') String t,
    @Default('') @JsonKey(name: 'ext:F') String f,
  }) = _GpxSac;

  factory GpxSac.fromJson(Map<String, Object?> json) => _$GpxSacFromJson(json);
}

@freezed
class GpxStatistics with _$GpxStatistics {
  factory GpxStatistics({
    @Default('') @JsonKey(name: 'ext:elevation_loss') String elevationLoss,
    @Default('') @JsonKey(name: 'ext:rating') String rating,
    @Default('') @JsonKey(name: 'ext:CS6') String cs6,
    @Default('') @JsonKey(name: 'ext:CS5') String cs5,
    @Default('') @JsonKey(name: 'ext:CS4') String cs4,
    @Default('') @JsonKey(name: 'ext:CS3') String cs3,
    @Default('') @JsonKey(name: 'ext:CS2') String cs2,
    @Default('') @JsonKey(name: 'ext:CS1') String cs1,
    @Default('') @JsonKey(name: 'ext:duration_hours') String durationHours,
    @Default('') @JsonKey(name: 'ext:peak_height') String peakHeight,
    @Default('') @JsonKey(name: 'ext:elevation_gain') String elevationGain,
    @Default('') @JsonKey(name: 'ext:min_height') String minHeight,
    @Default('') @JsonKey(name: 'ext:dist') String dist,
    @Default([])
    @JsonKey(name: 'ext:peaks', fromJson: parsePeak)
    List<GpxPeak> peak,
  }) = _GpxStatistics;

  factory GpxStatistics.fromJson(Map<String, Object?> json) =>
      _$GpxStatisticsFromJson(json);
}

List<GpxPeak> parsePeak(String value) {
  return List.from(
    (jsonDecode(value.replaceAll(r"'", '"')) as List<dynamic>).map(
      (e) => GpxPeak.fromJson(e),
    ),
  );
}

@freezed
class GpxPeak with _$GpxPeak {
  factory GpxPeak({
    @Default(0) double lat,
    @Default(0) double lon,
    @Default(0) @JsonKey(name: 'waypoint_index') double waypointIndex,
    @Default('') String name,
    @Default(0) @JsonKey(fromJson: getEle, name: 'attr') double ele,
  }) = _GpxPeak;

  factory GpxPeak.fromJson(Map<String, Object?> json) =>
      _$GpxPeakFromJson(json);
}

double getEle(Map<String, dynamic> map) {
  return double.tryParse(map['ele']) ?? 0;
}
