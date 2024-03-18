import 'package:isar/isar.dart';

part 'run_result.g.dart';

@collection
class RunResult {
  Id id = Isar.autoIncrement;

  DateTime? dateTime;
  int? totalSeconds;
  int? avgPaceSeconds;
  double? distance;
  double? kcal;
  List<PointLatLng>? points;
}

@embedded
class PointLatLng {
  double? latitude;
  double? longitude;
}
