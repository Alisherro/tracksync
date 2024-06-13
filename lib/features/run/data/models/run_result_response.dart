import 'package:intl/intl.dart';

import '../../domain/entities/run_result.dart';

class RunResultResponse {
  int? id;
  int? userId;
  String? distanceKm;
  String? startTime;
  String? endTime;
  String? totalTime;
  String? averageSpeed;
  String? maxSpeed;
  String? caloriesBurned;
  int? points;
  List<double> speeds = [];
  List<LocationResponse> locations = [];

  RunResultResponse({
    this.id,
    this.userId,
    this.distanceKm,
    this.startTime,
    this.endTime,
    this.totalTime,
    this.averageSpeed,
    this.maxSpeed,
    this.caloriesBurned,
    this.points,
    List<double>? speeds,
    List<LocationResponse>? locations,
  }) {
    this.speeds = speeds ?? this.speeds;
    this.locations = locations ?? this.locations;
  }

  RunResultResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    distanceKm = json['distance_km'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalTime = json['total_time'];
    averageSpeed = json['average_speed'];
    maxSpeed = json['max_speed'];
    caloriesBurned = json['calories_burned'];
    points = json['points'];
    speeds = List<double>.from(json['speeds'].map((x) => x.toDouble()));
    locations = List<LocationResponse>.from(
        json['locations'].map((x) => LocationResponse.fromMap(x)));
  }

  RunResult? toEntity() {
    if ([
      id,
      distanceKm,
      startTime,
      endTime,
      totalTime,
      averageSpeed,
      maxSpeed,
      caloriesBurned,
      points
    ].contains(null)) {
      return null;
    } else {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      return RunResult(
          id: id!,
          distance: double.tryParse(distanceKm!),
          avgPaceSeconds: int.tryParse(averageSpeed!),
          dateTime: dateFormat.parse(endTime!),
          kcal: double.tryParse(caloriesBurned!) ?? 0,
          totalSeconds: int.tryParse(totalTime ?? '0'),
          speeds: speeds,
          coins: points,
          points: locations.map((e) => e.toEntity()).toList());
    }
  }
}

class LocationResponse {
  final double latitude;
  final double longitude;

  LocationResponse({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory LocationResponse.fromMap(Map<String, dynamic> map) {
    return LocationResponse(
      latitude: map['latitude'].toDouble(),
      longitude: map['longitude'].toDouble(),
    );
  }

  PointLatLng toEntity() {
    return PointLatLng(latitude: latitude, longitude: longitude);
  }
}
