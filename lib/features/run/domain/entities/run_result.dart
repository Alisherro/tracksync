import 'package:isar/isar.dart';

part 'run_result.g.dart';

@collection
class RunResult {
  RunResult({this.avgPaceSeconds,
    this.points,
    this.speeds,
    this.dateTime,
    this.distance,
    this.coins,
    this.kcal,
    this.totalSeconds,
    this.id = Isar.autoIncrement});

  Id id;

  DateTime? dateTime;
  int? totalSeconds;
  int? avgPaceSeconds;
  double? distance;
  double? kcal;
  int? coins;
  List<PointLatLng>? points;
  List<double>? speeds;

  Map<String, dynamic> toMap() {
    String durationToString(Duration duration) {
      String negativeSign = duration.isNegative ? '-' : '';
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
      return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    return {
      'id': this.id,
      'start_time': this
          .dateTime
          ?.subtract(Duration(seconds: totalSeconds ?? 0))
          .toIso8601String(),
      'end_time': this.dateTime?.toIso8601String(),
      'total_time':durationToString(Duration(seconds: this.totalSeconds ?? 0)),
      'average_speed': this.avgPaceSeconds,
      'distance_km': this.distance,
      'calories_burned': this.kcal,
      'max_speed': 10.5,
      'points': coins,
      'speeds': speeds,
      'locations': points?.map((e) => e.toMap()).toList(),
    };
  }
}

@embedded
class PointLatLng {

  PointLatLng({ this.longitude,  this.latitude});
  double? latitude;
  double? longitude;

  Map<String, dynamic> toMap() {
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory PointLatLng.fromMap(Map<String, dynamic> map) {
    return PointLatLng(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}
