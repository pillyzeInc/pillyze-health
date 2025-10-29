part of '../health.dart';

/// A [RoutePoint] represents a single GPS coordinate along a workout route.
///
/// Contains:
///  * [latitude] - The latitude coordinate
///  * [longitude] - The longitude coordinate
///  * [altitude] - The altitude in meters (optional, can be null)
///  * [timestamp] - The timestamp when this coordinate was recorded
///  * [speed] - The speed in meters per second (optional, can be null)
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class RoutePoint {
  /// Latitude coordinate
  double latitude;

  /// Longitude coordinate
  double longitude;

  /// Altitude in meters (optional)
  double? altitude;

  /// Timestamp when this coordinate was recorded
  DateTime timestamp;

  /// Speed in meters per second (optional)
  double? speed;

  RoutePoint({
    required this.latitude,
    required this.longitude,
    this.altitude,
    required this.timestamp,
    this.speed,
  });

  /// Create a [RoutePoint] from a native data point format
  factory RoutePoint.fromHealthDataPoint(dynamic dataPoint) {
    return RoutePoint(
      latitude: (dataPoint['latitude'] as num).toDouble(),
      longitude: (dataPoint['longitude'] as num).toDouble(),
      altitude: dataPoint['altitude'] != null
          ? (dataPoint['altitude'] as num).toDouble()
          : null,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        dataPoint['timestamp'] as int,
      ),
      speed: dataPoint['speed'] != null
          ? (dataPoint['speed'] as num).toDouble()
          : null,
    );
  }

  /// Create a [RoutePoint] from JSON
  factory RoutePoint.fromJson(Map<String, dynamic> json) =>
      _$RoutePointFromJson(json);

  /// Convert this [RoutePoint] to JSON
  Map<String, dynamic> toJson() => _$RoutePointToJson(this);

  @override
  String toString() => '$runtimeType - '
      'latitude: $latitude, '
      'longitude: $longitude, '
      'altitude: $altitude, '
      'timestamp: $timestamp, '
      'speed: $speed';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutePoint &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          altitude == other.altitude &&
          timestamp == other.timestamp &&
          speed == other.speed;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      altitude.hashCode ^
      timestamp.hashCode ^
      speed.hashCode;
}