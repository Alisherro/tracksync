import 'package:isar/isar.dart';

part 'run_result.g.dart';

@collection
class RunResult {

  RunResult();

  Id id = Isar.autoIncrement;

  DateTime? dateTime;
  int? totalSeconds;
  int? avgPaceSeconds;
  double? distance;
  double? kcal;
  List<PointLatLng>? points;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'start_time': this.dateTime?.subtract(Duration(seconds: totalSeconds??0)).toIso8601String(),
      'end_time': this.dateTime?.toIso8601String(),
      'totalSeconds': Duration(seconds: this.totalSeconds??0).toString().substring(0,9),
      'average_speed': this.avgPaceSeconds,
      'distance_km': this.distance,
      'calories_burned': this.kcal,
      'max_speed': 10.5,
      'points':10,
    };
  }


}

@embedded
class PointLatLng {
  double? latitude;
  double? longitude;
}
