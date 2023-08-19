// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpx_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GpxChart _$$_GpxChartFromJson(Map<String, dynamic> json) => _$_GpxChart(
      gpxStatistics:
          GpxStatistics.fromJson(json['gpxStatistics'] as Map<String, dynamic>),
      gpxSac: GpxSac.fromJson(json['gpxSac'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GpxChartToJson(_$_GpxChart instance) =>
    <String, dynamic>{
      'gpxStatistics': instance.gpxStatistics,
      'gpxSac': instance.gpxSac,
    };

_$_GpxSac _$$_GpxSacFromJson(Map<String, dynamic> json) => _$_GpxSac(
      s: json['ext:S'] as String? ?? '',
      end: json['ext:end'] as String? ?? '',
      start: json['ext:start'] as String? ?? '',
      dist: json['ext:dist'] as String? ?? '',
      v: json['ext:V'] as String? ?? '',
      t: json['ext:T'] as String? ?? '',
      f: json['ext:F'] as String? ?? '',
    );

Map<String, dynamic> _$$_GpxSacToJson(_$_GpxSac instance) => <String, dynamic>{
      'ext:S': instance.s,
      'ext:end': instance.end,
      'ext:start': instance.start,
      'ext:dist': instance.dist,
      'ext:V': instance.v,
      'ext:T': instance.t,
      'ext:F': instance.f,
    };

_$_GpxStatistics _$$_GpxStatisticsFromJson(Map<String, dynamic> json) =>
    _$_GpxStatistics(
      elevationLoss: json['ext:elevation_loss'] as String? ?? '',
      rating: json['ext:rating'] as String? ?? '',
      cs6: json['ext:CS6'] as String? ?? '',
      cs5: json['ext:CS5'] as String? ?? '',
      cs4: json['ext:CS4'] as String? ?? '',
      cs3: json['ext:CS3'] as String? ?? '',
      cs2: json['ext:CS2'] as String? ?? '',
      cs1: json['ext:CS1'] as String? ?? '',
      durationHours: json['ext:duration_hours'] as String? ?? '',
      peakHeight: json['ext:peak_height'] as String? ?? '',
      elevationGain: json['ext:elevation_gain'] as String? ?? '',
      minHeight: json['ext:min_height'] as String? ?? '',
      dist: json['ext:dist'] as String? ?? '',
      peak: json['ext:peaks'] == null
          ? const []
          : parsePeak(json['ext:peaks'] as String),
    );

Map<String, dynamic> _$$_GpxStatisticsToJson(_$_GpxStatistics instance) =>
    <String, dynamic>{
      'ext:elevation_loss': instance.elevationLoss,
      'ext:rating': instance.rating,
      'ext:CS6': instance.cs6,
      'ext:CS5': instance.cs5,
      'ext:CS4': instance.cs4,
      'ext:CS3': instance.cs3,
      'ext:CS2': instance.cs2,
      'ext:CS1': instance.cs1,
      'ext:duration_hours': instance.durationHours,
      'ext:peak_height': instance.peakHeight,
      'ext:elevation_gain': instance.elevationGain,
      'ext:min_height': instance.minHeight,
      'ext:dist': instance.dist,
      'ext:peaks': instance.peak,
    };

_$_GpxPeak _$$_GpxPeakFromJson(Map<String, dynamic> json) => _$_GpxPeak(
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0,
      waypointIndex: (json['waypoint_index'] as num?)?.toDouble() ?? 0,
      name: json['name'] as String? ?? '',
      ele: json['attr'] == null
          ? 0
          : getEle(json['attr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GpxPeakToJson(_$_GpxPeak instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'waypoint_index': instance.waypointIndex,
      'name': instance.name,
      'attr': instance.ele,
    };
