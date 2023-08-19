// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gpx_chart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GpxChart _$GpxChartFromJson(Map<String, dynamic> json) {
  return _GpxChart.fromJson(json);
}

/// @nodoc
mixin _$GpxChart {
  GpxStatistics get gpxStatistics => throw _privateConstructorUsedError;
  GpxSac get gpxSac => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GpxChartCopyWith<GpxChart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpxChartCopyWith<$Res> {
  factory $GpxChartCopyWith(GpxChart value, $Res Function(GpxChart) then) =
      _$GpxChartCopyWithImpl<$Res, GpxChart>;
  @useResult
  $Res call({GpxStatistics gpxStatistics, GpxSac gpxSac});

  $GpxStatisticsCopyWith<$Res> get gpxStatistics;
  $GpxSacCopyWith<$Res> get gpxSac;
}

/// @nodoc
class _$GpxChartCopyWithImpl<$Res, $Val extends GpxChart>
    implements $GpxChartCopyWith<$Res> {
  _$GpxChartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpxStatistics = null,
    Object? gpxSac = null,
  }) {
    return _then(_value.copyWith(
      gpxStatistics: null == gpxStatistics
          ? _value.gpxStatistics
          : gpxStatistics // ignore: cast_nullable_to_non_nullable
              as GpxStatistics,
      gpxSac: null == gpxSac
          ? _value.gpxSac
          : gpxSac // ignore: cast_nullable_to_non_nullable
              as GpxSac,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GpxStatisticsCopyWith<$Res> get gpxStatistics {
    return $GpxStatisticsCopyWith<$Res>(_value.gpxStatistics, (value) {
      return _then(_value.copyWith(gpxStatistics: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GpxSacCopyWith<$Res> get gpxSac {
    return $GpxSacCopyWith<$Res>(_value.gpxSac, (value) {
      return _then(_value.copyWith(gpxSac: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GpxChartCopyWith<$Res> implements $GpxChartCopyWith<$Res> {
  factory _$$_GpxChartCopyWith(
          _$_GpxChart value, $Res Function(_$_GpxChart) then) =
      __$$_GpxChartCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GpxStatistics gpxStatistics, GpxSac gpxSac});

  @override
  $GpxStatisticsCopyWith<$Res> get gpxStatistics;
  @override
  $GpxSacCopyWith<$Res> get gpxSac;
}

/// @nodoc
class __$$_GpxChartCopyWithImpl<$Res>
    extends _$GpxChartCopyWithImpl<$Res, _$_GpxChart>
    implements _$$_GpxChartCopyWith<$Res> {
  __$$_GpxChartCopyWithImpl(
      _$_GpxChart _value, $Res Function(_$_GpxChart) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpxStatistics = null,
    Object? gpxSac = null,
  }) {
    return _then(_$_GpxChart(
      gpxStatistics: null == gpxStatistics
          ? _value.gpxStatistics
          : gpxStatistics // ignore: cast_nullable_to_non_nullable
              as GpxStatistics,
      gpxSac: null == gpxSac
          ? _value.gpxSac
          : gpxSac // ignore: cast_nullable_to_non_nullable
              as GpxSac,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GpxChart implements _GpxChart {
  _$_GpxChart({required this.gpxStatistics, required this.gpxSac});

  factory _$_GpxChart.fromJson(Map<String, dynamic> json) =>
      _$$_GpxChartFromJson(json);

  @override
  final GpxStatistics gpxStatistics;
  @override
  final GpxSac gpxSac;

  @override
  String toString() {
    return 'GpxChart(gpxStatistics: $gpxStatistics, gpxSac: $gpxSac)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GpxChart &&
            (identical(other.gpxStatistics, gpxStatistics) ||
                other.gpxStatistics == gpxStatistics) &&
            (identical(other.gpxSac, gpxSac) || other.gpxSac == gpxSac));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gpxStatistics, gpxSac);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GpxChartCopyWith<_$_GpxChart> get copyWith =>
      __$$_GpxChartCopyWithImpl<_$_GpxChart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GpxChartToJson(
      this,
    );
  }
}

abstract class _GpxChart implements GpxChart {
  factory _GpxChart(
      {required final GpxStatistics gpxStatistics,
      required final GpxSac gpxSac}) = _$_GpxChart;

  factory _GpxChart.fromJson(Map<String, dynamic> json) = _$_GpxChart.fromJson;

  @override
  GpxStatistics get gpxStatistics;
  @override
  GpxSac get gpxSac;
  @override
  @JsonKey(ignore: true)
  _$$_GpxChartCopyWith<_$_GpxChart> get copyWith =>
      throw _privateConstructorUsedError;
}

GpxSac _$GpxSacFromJson(Map<String, dynamic> json) {
  return _GpxSac.fromJson(json);
}

/// @nodoc
mixin _$GpxSac {
  @JsonKey(name: 'ext:S')
  String get s => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:end')
  String get end => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:start')
  String get start => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:dist')
  String get dist => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:V')
  String get v => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:T')
  String get t => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:F')
  String get f => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GpxSacCopyWith<GpxSac> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpxSacCopyWith<$Res> {
  factory $GpxSacCopyWith(GpxSac value, $Res Function(GpxSac) then) =
      _$GpxSacCopyWithImpl<$Res, GpxSac>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ext:S') String s,
      @JsonKey(name: 'ext:end') String end,
      @JsonKey(name: 'ext:start') String start,
      @JsonKey(name: 'ext:dist') String dist,
      @JsonKey(name: 'ext:V') String v,
      @JsonKey(name: 'ext:T') String t,
      @JsonKey(name: 'ext:F') String f});
}

/// @nodoc
class _$GpxSacCopyWithImpl<$Res, $Val extends GpxSac>
    implements $GpxSacCopyWith<$Res> {
  _$GpxSacCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? s = null,
    Object? end = null,
    Object? start = null,
    Object? dist = null,
    Object? v = null,
    Object? t = null,
    Object? f = null,
  }) {
    return _then(_value.copyWith(
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      dist: null == dist
          ? _value.dist
          : dist // ignore: cast_nullable_to_non_nullable
              as String,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as String,
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as String,
      f: null == f
          ? _value.f
          : f // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GpxSacCopyWith<$Res> implements $GpxSacCopyWith<$Res> {
  factory _$$_GpxSacCopyWith(_$_GpxSac value, $Res Function(_$_GpxSac) then) =
      __$$_GpxSacCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ext:S') String s,
      @JsonKey(name: 'ext:end') String end,
      @JsonKey(name: 'ext:start') String start,
      @JsonKey(name: 'ext:dist') String dist,
      @JsonKey(name: 'ext:V') String v,
      @JsonKey(name: 'ext:T') String t,
      @JsonKey(name: 'ext:F') String f});
}

/// @nodoc
class __$$_GpxSacCopyWithImpl<$Res>
    extends _$GpxSacCopyWithImpl<$Res, _$_GpxSac>
    implements _$$_GpxSacCopyWith<$Res> {
  __$$_GpxSacCopyWithImpl(_$_GpxSac _value, $Res Function(_$_GpxSac) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? s = null,
    Object? end = null,
    Object? start = null,
    Object? dist = null,
    Object? v = null,
    Object? t = null,
    Object? f = null,
  }) {
    return _then(_$_GpxSac(
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      dist: null == dist
          ? _value.dist
          : dist // ignore: cast_nullable_to_non_nullable
              as String,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as String,
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as String,
      f: null == f
          ? _value.f
          : f // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GpxSac implements _GpxSac {
  _$_GpxSac(
      {@JsonKey(name: 'ext:S') this.s = '',
      @JsonKey(name: 'ext:end') this.end = '',
      @JsonKey(name: 'ext:start') this.start = '',
      @JsonKey(name: 'ext:dist') this.dist = '',
      @JsonKey(name: 'ext:V') this.v = '',
      @JsonKey(name: 'ext:T') this.t = '',
      @JsonKey(name: 'ext:F') this.f = ''});

  factory _$_GpxSac.fromJson(Map<String, dynamic> json) =>
      _$$_GpxSacFromJson(json);

  @override
  @JsonKey(name: 'ext:S')
  final String s;
  @override
  @JsonKey(name: 'ext:end')
  final String end;
  @override
  @JsonKey(name: 'ext:start')
  final String start;
  @override
  @JsonKey(name: 'ext:dist')
  final String dist;
  @override
  @JsonKey(name: 'ext:V')
  final String v;
  @override
  @JsonKey(name: 'ext:T')
  final String t;
  @override
  @JsonKey(name: 'ext:F')
  final String f;

  @override
  String toString() {
    return 'GpxSac(s: $s, end: $end, start: $start, dist: $dist, v: $v, t: $t, f: $f)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GpxSac &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.dist, dist) || other.dist == dist) &&
            (identical(other.v, v) || other.v == v) &&
            (identical(other.t, t) || other.t == t) &&
            (identical(other.f, f) || other.f == f));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, s, end, start, dist, v, t, f);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GpxSacCopyWith<_$_GpxSac> get copyWith =>
      __$$_GpxSacCopyWithImpl<_$_GpxSac>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GpxSacToJson(
      this,
    );
  }
}

abstract class _GpxSac implements GpxSac {
  factory _GpxSac(
      {@JsonKey(name: 'ext:S') final String s,
      @JsonKey(name: 'ext:end') final String end,
      @JsonKey(name: 'ext:start') final String start,
      @JsonKey(name: 'ext:dist') final String dist,
      @JsonKey(name: 'ext:V') final String v,
      @JsonKey(name: 'ext:T') final String t,
      @JsonKey(name: 'ext:F') final String f}) = _$_GpxSac;

  factory _GpxSac.fromJson(Map<String, dynamic> json) = _$_GpxSac.fromJson;

  @override
  @JsonKey(name: 'ext:S')
  String get s;
  @override
  @JsonKey(name: 'ext:end')
  String get end;
  @override
  @JsonKey(name: 'ext:start')
  String get start;
  @override
  @JsonKey(name: 'ext:dist')
  String get dist;
  @override
  @JsonKey(name: 'ext:V')
  String get v;
  @override
  @JsonKey(name: 'ext:T')
  String get t;
  @override
  @JsonKey(name: 'ext:F')
  String get f;
  @override
  @JsonKey(ignore: true)
  _$$_GpxSacCopyWith<_$_GpxSac> get copyWith =>
      throw _privateConstructorUsedError;
}

GpxStatistics _$GpxStatisticsFromJson(Map<String, dynamic> json) {
  return _GpxStatistics.fromJson(json);
}

/// @nodoc
mixin _$GpxStatistics {
  @JsonKey(name: 'ext:elevation_loss')
  String get elevationLoss => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:rating')
  String get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:CS6')
  String get cs6 => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:CS5')
  String get cs5 => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:CS4')
  String get cs4 => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:CS3')
  String get cs3 => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:CS2')
  String get cs2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:CS1')
  String get cs1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:duration_hours')
  String get durationHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:peak_height')
  String get peakHeight => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:elevation_gain')
  String get elevationGain => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:min_height')
  String get minHeight => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:dist')
  String get dist => throw _privateConstructorUsedError;
  @JsonKey(name: 'ext:peaks', fromJson: parsePeak)
  List<GpxPeak> get peak => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GpxStatisticsCopyWith<GpxStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpxStatisticsCopyWith<$Res> {
  factory $GpxStatisticsCopyWith(
          GpxStatistics value, $Res Function(GpxStatistics) then) =
      _$GpxStatisticsCopyWithImpl<$Res, GpxStatistics>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ext:elevation_loss') String elevationLoss,
      @JsonKey(name: 'ext:rating') String rating,
      @JsonKey(name: 'ext:CS6') String cs6,
      @JsonKey(name: 'ext:CS5') String cs5,
      @JsonKey(name: 'ext:CS4') String cs4,
      @JsonKey(name: 'ext:CS3') String cs3,
      @JsonKey(name: 'ext:CS2') String cs2,
      @JsonKey(name: 'ext:CS1') String cs1,
      @JsonKey(name: 'ext:duration_hours') String durationHours,
      @JsonKey(name: 'ext:peak_height') String peakHeight,
      @JsonKey(name: 'ext:elevation_gain') String elevationGain,
      @JsonKey(name: 'ext:min_height') String minHeight,
      @JsonKey(name: 'ext:dist') String dist,
      @JsonKey(name: 'ext:peaks', fromJson: parsePeak) List<GpxPeak> peak});
}

/// @nodoc
class _$GpxStatisticsCopyWithImpl<$Res, $Val extends GpxStatistics>
    implements $GpxStatisticsCopyWith<$Res> {
  _$GpxStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elevationLoss = null,
    Object? rating = null,
    Object? cs6 = null,
    Object? cs5 = null,
    Object? cs4 = null,
    Object? cs3 = null,
    Object? cs2 = null,
    Object? cs1 = null,
    Object? durationHours = null,
    Object? peakHeight = null,
    Object? elevationGain = null,
    Object? minHeight = null,
    Object? dist = null,
    Object? peak = null,
  }) {
    return _then(_value.copyWith(
      elevationLoss: null == elevationLoss
          ? _value.elevationLoss
          : elevationLoss // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
      cs6: null == cs6
          ? _value.cs6
          : cs6 // ignore: cast_nullable_to_non_nullable
              as String,
      cs5: null == cs5
          ? _value.cs5
          : cs5 // ignore: cast_nullable_to_non_nullable
              as String,
      cs4: null == cs4
          ? _value.cs4
          : cs4 // ignore: cast_nullable_to_non_nullable
              as String,
      cs3: null == cs3
          ? _value.cs3
          : cs3 // ignore: cast_nullable_to_non_nullable
              as String,
      cs2: null == cs2
          ? _value.cs2
          : cs2 // ignore: cast_nullable_to_non_nullable
              as String,
      cs1: null == cs1
          ? _value.cs1
          : cs1 // ignore: cast_nullable_to_non_nullable
              as String,
      durationHours: null == durationHours
          ? _value.durationHours
          : durationHours // ignore: cast_nullable_to_non_nullable
              as String,
      peakHeight: null == peakHeight
          ? _value.peakHeight
          : peakHeight // ignore: cast_nullable_to_non_nullable
              as String,
      elevationGain: null == elevationGain
          ? _value.elevationGain
          : elevationGain // ignore: cast_nullable_to_non_nullable
              as String,
      minHeight: null == minHeight
          ? _value.minHeight
          : minHeight // ignore: cast_nullable_to_non_nullable
              as String,
      dist: null == dist
          ? _value.dist
          : dist // ignore: cast_nullable_to_non_nullable
              as String,
      peak: null == peak
          ? _value.peak
          : peak // ignore: cast_nullable_to_non_nullable
              as List<GpxPeak>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GpxStatisticsCopyWith<$Res>
    implements $GpxStatisticsCopyWith<$Res> {
  factory _$$_GpxStatisticsCopyWith(
          _$_GpxStatistics value, $Res Function(_$_GpxStatistics) then) =
      __$$_GpxStatisticsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ext:elevation_loss') String elevationLoss,
      @JsonKey(name: 'ext:rating') String rating,
      @JsonKey(name: 'ext:CS6') String cs6,
      @JsonKey(name: 'ext:CS5') String cs5,
      @JsonKey(name: 'ext:CS4') String cs4,
      @JsonKey(name: 'ext:CS3') String cs3,
      @JsonKey(name: 'ext:CS2') String cs2,
      @JsonKey(name: 'ext:CS1') String cs1,
      @JsonKey(name: 'ext:duration_hours') String durationHours,
      @JsonKey(name: 'ext:peak_height') String peakHeight,
      @JsonKey(name: 'ext:elevation_gain') String elevationGain,
      @JsonKey(name: 'ext:min_height') String minHeight,
      @JsonKey(name: 'ext:dist') String dist,
      @JsonKey(name: 'ext:peaks', fromJson: parsePeak) List<GpxPeak> peak});
}

/// @nodoc
class __$$_GpxStatisticsCopyWithImpl<$Res>
    extends _$GpxStatisticsCopyWithImpl<$Res, _$_GpxStatistics>
    implements _$$_GpxStatisticsCopyWith<$Res> {
  __$$_GpxStatisticsCopyWithImpl(
      _$_GpxStatistics _value, $Res Function(_$_GpxStatistics) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elevationLoss = null,
    Object? rating = null,
    Object? cs6 = null,
    Object? cs5 = null,
    Object? cs4 = null,
    Object? cs3 = null,
    Object? cs2 = null,
    Object? cs1 = null,
    Object? durationHours = null,
    Object? peakHeight = null,
    Object? elevationGain = null,
    Object? minHeight = null,
    Object? dist = null,
    Object? peak = null,
  }) {
    return _then(_$_GpxStatistics(
      elevationLoss: null == elevationLoss
          ? _value.elevationLoss
          : elevationLoss // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
      cs6: null == cs6
          ? _value.cs6
          : cs6 // ignore: cast_nullable_to_non_nullable
              as String,
      cs5: null == cs5
          ? _value.cs5
          : cs5 // ignore: cast_nullable_to_non_nullable
              as String,
      cs4: null == cs4
          ? _value.cs4
          : cs4 // ignore: cast_nullable_to_non_nullable
              as String,
      cs3: null == cs3
          ? _value.cs3
          : cs3 // ignore: cast_nullable_to_non_nullable
              as String,
      cs2: null == cs2
          ? _value.cs2
          : cs2 // ignore: cast_nullable_to_non_nullable
              as String,
      cs1: null == cs1
          ? _value.cs1
          : cs1 // ignore: cast_nullable_to_non_nullable
              as String,
      durationHours: null == durationHours
          ? _value.durationHours
          : durationHours // ignore: cast_nullable_to_non_nullable
              as String,
      peakHeight: null == peakHeight
          ? _value.peakHeight
          : peakHeight // ignore: cast_nullable_to_non_nullable
              as String,
      elevationGain: null == elevationGain
          ? _value.elevationGain
          : elevationGain // ignore: cast_nullable_to_non_nullable
              as String,
      minHeight: null == minHeight
          ? _value.minHeight
          : minHeight // ignore: cast_nullable_to_non_nullable
              as String,
      dist: null == dist
          ? _value.dist
          : dist // ignore: cast_nullable_to_non_nullable
              as String,
      peak: null == peak
          ? _value._peak
          : peak // ignore: cast_nullable_to_non_nullable
              as List<GpxPeak>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GpxStatistics implements _GpxStatistics {
  _$_GpxStatistics(
      {@JsonKey(name: 'ext:elevation_loss') this.elevationLoss = '',
      @JsonKey(name: 'ext:rating') this.rating = '',
      @JsonKey(name: 'ext:CS6') this.cs6 = '',
      @JsonKey(name: 'ext:CS5') this.cs5 = '',
      @JsonKey(name: 'ext:CS4') this.cs4 = '',
      @JsonKey(name: 'ext:CS3') this.cs3 = '',
      @JsonKey(name: 'ext:CS2') this.cs2 = '',
      @JsonKey(name: 'ext:CS1') this.cs1 = '',
      @JsonKey(name: 'ext:duration_hours') this.durationHours = '',
      @JsonKey(name: 'ext:peak_height') this.peakHeight = '',
      @JsonKey(name: 'ext:elevation_gain') this.elevationGain = '',
      @JsonKey(name: 'ext:min_height') this.minHeight = '',
      @JsonKey(name: 'ext:dist') this.dist = '',
      @JsonKey(name: 'ext:peaks', fromJson: parsePeak)
      final List<GpxPeak> peak = const []})
      : _peak = peak;

  factory _$_GpxStatistics.fromJson(Map<String, dynamic> json) =>
      _$$_GpxStatisticsFromJson(json);

  @override
  @JsonKey(name: 'ext:elevation_loss')
  final String elevationLoss;
  @override
  @JsonKey(name: 'ext:rating')
  final String rating;
  @override
  @JsonKey(name: 'ext:CS6')
  final String cs6;
  @override
  @JsonKey(name: 'ext:CS5')
  final String cs5;
  @override
  @JsonKey(name: 'ext:CS4')
  final String cs4;
  @override
  @JsonKey(name: 'ext:CS3')
  final String cs3;
  @override
  @JsonKey(name: 'ext:CS2')
  final String cs2;
  @override
  @JsonKey(name: 'ext:CS1')
  final String cs1;
  @override
  @JsonKey(name: 'ext:duration_hours')
  final String durationHours;
  @override
  @JsonKey(name: 'ext:peak_height')
  final String peakHeight;
  @override
  @JsonKey(name: 'ext:elevation_gain')
  final String elevationGain;
  @override
  @JsonKey(name: 'ext:min_height')
  final String minHeight;
  @override
  @JsonKey(name: 'ext:dist')
  final String dist;
  final List<GpxPeak> _peak;
  @override
  @JsonKey(name: 'ext:peaks', fromJson: parsePeak)
  List<GpxPeak> get peak {
    if (_peak is EqualUnmodifiableListView) return _peak;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peak);
  }

  @override
  String toString() {
    return 'GpxStatistics(elevationLoss: $elevationLoss, rating: $rating, cs6: $cs6, cs5: $cs5, cs4: $cs4, cs3: $cs3, cs2: $cs2, cs1: $cs1, durationHours: $durationHours, peakHeight: $peakHeight, elevationGain: $elevationGain, minHeight: $minHeight, dist: $dist, peak: $peak)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GpxStatistics &&
            (identical(other.elevationLoss, elevationLoss) ||
                other.elevationLoss == elevationLoss) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.cs6, cs6) || other.cs6 == cs6) &&
            (identical(other.cs5, cs5) || other.cs5 == cs5) &&
            (identical(other.cs4, cs4) || other.cs4 == cs4) &&
            (identical(other.cs3, cs3) || other.cs3 == cs3) &&
            (identical(other.cs2, cs2) || other.cs2 == cs2) &&
            (identical(other.cs1, cs1) || other.cs1 == cs1) &&
            (identical(other.durationHours, durationHours) ||
                other.durationHours == durationHours) &&
            (identical(other.peakHeight, peakHeight) ||
                other.peakHeight == peakHeight) &&
            (identical(other.elevationGain, elevationGain) ||
                other.elevationGain == elevationGain) &&
            (identical(other.minHeight, minHeight) ||
                other.minHeight == minHeight) &&
            (identical(other.dist, dist) || other.dist == dist) &&
            const DeepCollectionEquality().equals(other._peak, _peak));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      elevationLoss,
      rating,
      cs6,
      cs5,
      cs4,
      cs3,
      cs2,
      cs1,
      durationHours,
      peakHeight,
      elevationGain,
      minHeight,
      dist,
      const DeepCollectionEquality().hash(_peak));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GpxStatisticsCopyWith<_$_GpxStatistics> get copyWith =>
      __$$_GpxStatisticsCopyWithImpl<_$_GpxStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GpxStatisticsToJson(
      this,
    );
  }
}

abstract class _GpxStatistics implements GpxStatistics {
  factory _GpxStatistics(
      {@JsonKey(name: 'ext:elevation_loss') final String elevationLoss,
      @JsonKey(name: 'ext:rating') final String rating,
      @JsonKey(name: 'ext:CS6') final String cs6,
      @JsonKey(name: 'ext:CS5') final String cs5,
      @JsonKey(name: 'ext:CS4') final String cs4,
      @JsonKey(name: 'ext:CS3') final String cs3,
      @JsonKey(name: 'ext:CS2') final String cs2,
      @JsonKey(name: 'ext:CS1') final String cs1,
      @JsonKey(name: 'ext:duration_hours') final String durationHours,
      @JsonKey(name: 'ext:peak_height') final String peakHeight,
      @JsonKey(name: 'ext:elevation_gain') final String elevationGain,
      @JsonKey(name: 'ext:min_height') final String minHeight,
      @JsonKey(name: 'ext:dist') final String dist,
      @JsonKey(name: 'ext:peaks', fromJson: parsePeak)
      final List<GpxPeak> peak}) = _$_GpxStatistics;

  factory _GpxStatistics.fromJson(Map<String, dynamic> json) =
      _$_GpxStatistics.fromJson;

  @override
  @JsonKey(name: 'ext:elevation_loss')
  String get elevationLoss;
  @override
  @JsonKey(name: 'ext:rating')
  String get rating;
  @override
  @JsonKey(name: 'ext:CS6')
  String get cs6;
  @override
  @JsonKey(name: 'ext:CS5')
  String get cs5;
  @override
  @JsonKey(name: 'ext:CS4')
  String get cs4;
  @override
  @JsonKey(name: 'ext:CS3')
  String get cs3;
  @override
  @JsonKey(name: 'ext:CS2')
  String get cs2;
  @override
  @JsonKey(name: 'ext:CS1')
  String get cs1;
  @override
  @JsonKey(name: 'ext:duration_hours')
  String get durationHours;
  @override
  @JsonKey(name: 'ext:peak_height')
  String get peakHeight;
  @override
  @JsonKey(name: 'ext:elevation_gain')
  String get elevationGain;
  @override
  @JsonKey(name: 'ext:min_height')
  String get minHeight;
  @override
  @JsonKey(name: 'ext:dist')
  String get dist;
  @override
  @JsonKey(name: 'ext:peaks', fromJson: parsePeak)
  List<GpxPeak> get peak;
  @override
  @JsonKey(ignore: true)
  _$$_GpxStatisticsCopyWith<_$_GpxStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

GpxPeak _$GpxPeakFromJson(Map<String, dynamic> json) {
  return _GpxPeak.fromJson(json);
}

/// @nodoc
mixin _$GpxPeak {
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  @JsonKey(name: 'waypoint_index')
  double get waypointIndex => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: getEle, name: 'attr')
  double get ele => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GpxPeakCopyWith<GpxPeak> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpxPeakCopyWith<$Res> {
  factory $GpxPeakCopyWith(GpxPeak value, $Res Function(GpxPeak) then) =
      _$GpxPeakCopyWithImpl<$Res, GpxPeak>;
  @useResult
  $Res call(
      {double lat,
      double lon,
      @JsonKey(name: 'waypoint_index') double waypointIndex,
      String name,
      @JsonKey(fromJson: getEle, name: 'attr') double ele});
}

/// @nodoc
class _$GpxPeakCopyWithImpl<$Res, $Val extends GpxPeak>
    implements $GpxPeakCopyWith<$Res> {
  _$GpxPeakCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lon = null,
    Object? waypointIndex = null,
    Object? name = null,
    Object? ele = null,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      waypointIndex: null == waypointIndex
          ? _value.waypointIndex
          : waypointIndex // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ele: null == ele
          ? _value.ele
          : ele // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GpxPeakCopyWith<$Res> implements $GpxPeakCopyWith<$Res> {
  factory _$$_GpxPeakCopyWith(
          _$_GpxPeak value, $Res Function(_$_GpxPeak) then) =
      __$$_GpxPeakCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double lat,
      double lon,
      @JsonKey(name: 'waypoint_index') double waypointIndex,
      String name,
      @JsonKey(fromJson: getEle, name: 'attr') double ele});
}

/// @nodoc
class __$$_GpxPeakCopyWithImpl<$Res>
    extends _$GpxPeakCopyWithImpl<$Res, _$_GpxPeak>
    implements _$$_GpxPeakCopyWith<$Res> {
  __$$_GpxPeakCopyWithImpl(_$_GpxPeak _value, $Res Function(_$_GpxPeak) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lon = null,
    Object? waypointIndex = null,
    Object? name = null,
    Object? ele = null,
  }) {
    return _then(_$_GpxPeak(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      waypointIndex: null == waypointIndex
          ? _value.waypointIndex
          : waypointIndex // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ele: null == ele
          ? _value.ele
          : ele // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GpxPeak implements _GpxPeak {
  _$_GpxPeak(
      {this.lat = 0,
      this.lon = 0,
      @JsonKey(name: 'waypoint_index') this.waypointIndex = 0,
      this.name = '',
      @JsonKey(fromJson: getEle, name: 'attr') this.ele = 0});

  factory _$_GpxPeak.fromJson(Map<String, dynamic> json) =>
      _$$_GpxPeakFromJson(json);

  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double lon;
  @override
  @JsonKey(name: 'waypoint_index')
  final double waypointIndex;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(fromJson: getEle, name: 'attr')
  final double ele;

  @override
  String toString() {
    return 'GpxPeak(lat: $lat, lon: $lon, waypointIndex: $waypointIndex, name: $name, ele: $ele)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GpxPeak &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.waypointIndex, waypointIndex) ||
                other.waypointIndex == waypointIndex) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ele, ele) || other.ele == ele));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, lat, lon, waypointIndex, name, ele);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GpxPeakCopyWith<_$_GpxPeak> get copyWith =>
      __$$_GpxPeakCopyWithImpl<_$_GpxPeak>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GpxPeakToJson(
      this,
    );
  }
}

abstract class _GpxPeak implements GpxPeak {
  factory _GpxPeak(
      {final double lat,
      final double lon,
      @JsonKey(name: 'waypoint_index') final double waypointIndex,
      final String name,
      @JsonKey(fromJson: getEle, name: 'attr') final double ele}) = _$_GpxPeak;

  factory _GpxPeak.fromJson(Map<String, dynamic> json) = _$_GpxPeak.fromJson;

  @override
  double get lat;
  @override
  double get lon;
  @override
  @JsonKey(name: 'waypoint_index')
  double get waypointIndex;
  @override
  String get name;
  @override
  @JsonKey(fromJson: getEle, name: 'attr')
  double get ele;
  @override
  @JsonKey(ignore: true)
  _$$_GpxPeakCopyWith<_$_GpxPeak> get copyWith =>
      throw _privateConstructorUsedError;
}
