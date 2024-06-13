// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_result.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRunResultCollection on Isar {
  IsarCollection<RunResult> get runResults => this.collection();
}

const RunResultSchema = CollectionSchema(
  name: r'RunResult',
  id: 9198907301335925981,
  properties: {
    r'avgPaceSeconds': PropertySchema(
      id: 0,
      name: r'avgPaceSeconds',
      type: IsarType.long,
    ),
    r'coins': PropertySchema(
      id: 1,
      name: r'coins',
      type: IsarType.long,
    ),
    r'dateTime': PropertySchema(
      id: 2,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'distance': PropertySchema(
      id: 3,
      name: r'distance',
      type: IsarType.double,
    ),
    r'kcal': PropertySchema(
      id: 4,
      name: r'kcal',
      type: IsarType.double,
    ),
    r'points': PropertySchema(
      id: 5,
      name: r'points',
      type: IsarType.objectList,
      target: r'PointLatLng',
    ),
    r'speeds': PropertySchema(
      id: 6,
      name: r'speeds',
      type: IsarType.doubleList,
    ),
    r'totalSeconds': PropertySchema(
      id: 7,
      name: r'totalSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _runResultEstimateSize,
  serialize: _runResultSerialize,
  deserialize: _runResultDeserialize,
  deserializeProp: _runResultDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'PointLatLng': PointLatLngSchema},
  getId: _runResultGetId,
  getLinks: _runResultGetLinks,
  attach: _runResultAttach,
  version: '3.1.0+1',
);

int _runResultEstimateSize(
  RunResult object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.points;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[PointLatLng]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              PointLatLngSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.speeds;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _runResultSerialize(
  RunResult object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.avgPaceSeconds);
  writer.writeLong(offsets[1], object.coins);
  writer.writeDateTime(offsets[2], object.dateTime);
  writer.writeDouble(offsets[3], object.distance);
  writer.writeDouble(offsets[4], object.kcal);
  writer.writeObjectList<PointLatLng>(
    offsets[5],
    allOffsets,
    PointLatLngSchema.serialize,
    object.points,
  );
  writer.writeDoubleList(offsets[6], object.speeds);
  writer.writeLong(offsets[7], object.totalSeconds);
}

RunResult _runResultDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RunResult(
    avgPaceSeconds: reader.readLongOrNull(offsets[0]),
    coins: reader.readLongOrNull(offsets[1]),
    dateTime: reader.readDateTimeOrNull(offsets[2]),
    distance: reader.readDoubleOrNull(offsets[3]),
    id: id,
    kcal: reader.readDoubleOrNull(offsets[4]),
    points: reader.readObjectList<PointLatLng>(
      offsets[5],
      PointLatLngSchema.deserialize,
      allOffsets,
      PointLatLng(),
    ),
    speeds: reader.readDoubleList(offsets[6]),
    totalSeconds: reader.readLongOrNull(offsets[7]),
  );
  return object;
}

P _runResultDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readObjectList<PointLatLng>(
        offset,
        PointLatLngSchema.deserialize,
        allOffsets,
        PointLatLng(),
      )) as P;
    case 6:
      return (reader.readDoubleList(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _runResultGetId(RunResult object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _runResultGetLinks(RunResult object) {
  return [];
}

void _runResultAttach(IsarCollection<dynamic> col, Id id, RunResult object) {
  object.id = id;
}

extension RunResultQueryWhereSort
    on QueryBuilder<RunResult, RunResult, QWhere> {
  QueryBuilder<RunResult, RunResult, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RunResultQueryWhere
    on QueryBuilder<RunResult, RunResult, QWhereClause> {
  QueryBuilder<RunResult, RunResult, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RunResultQueryFilter
    on QueryBuilder<RunResult, RunResult, QFilterCondition> {
  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      avgPaceSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avgPaceSeconds',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      avgPaceSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avgPaceSeconds',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      avgPaceSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgPaceSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      avgPaceSecondsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgPaceSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      avgPaceSecondsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgPaceSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      avgPaceSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgPaceSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> coinsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coins',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> coinsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coins',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> coinsEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> coinsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> coinsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> coinsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> dateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      dateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> dateTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> dateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> dateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> dateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> distanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'distance',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      distanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'distance',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> distanceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> distanceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> distanceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> distanceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> kcalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kcal',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> kcalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kcal',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> kcalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kcal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> kcalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kcal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> kcalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kcal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> kcalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kcal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> pointsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'points',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> pointsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'points',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> pointsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'points',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> pointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'points',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> pointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'points',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      pointsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'points',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      pointsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'points',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> pointsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'points',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> speedsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'speeds',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> speedsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'speeds',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      speedsElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speeds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      speedsElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speeds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      speedsElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speeds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      speedsElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speeds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> speedsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'speeds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> speedsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'speeds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> speedsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'speeds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      speedsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'speeds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      speedsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'speeds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> speedsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'speeds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      totalSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalSeconds',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      totalSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalSeconds',
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> totalSecondsEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      totalSecondsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition>
      totalSecondsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> totalSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RunResultQueryObject
    on QueryBuilder<RunResult, RunResult, QFilterCondition> {
  QueryBuilder<RunResult, RunResult, QAfterFilterCondition> pointsElement(
      FilterQuery<PointLatLng> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'points');
    });
  }
}

extension RunResultQueryLinks
    on QueryBuilder<RunResult, RunResult, QFilterCondition> {}

extension RunResultQuerySortBy on QueryBuilder<RunResult, RunResult, QSortBy> {
  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByAvgPaceSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPaceSeconds', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByAvgPaceSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPaceSeconds', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByKcalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByTotalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSeconds', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> sortByTotalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSeconds', Sort.desc);
    });
  }
}

extension RunResultQuerySortThenBy
    on QueryBuilder<RunResult, RunResult, QSortThenBy> {
  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByAvgPaceSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPaceSeconds', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByAvgPaceSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPaceSeconds', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByKcalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.desc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByTotalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSeconds', Sort.asc);
    });
  }

  QueryBuilder<RunResult, RunResult, QAfterSortBy> thenByTotalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSeconds', Sort.desc);
    });
  }
}

extension RunResultQueryWhereDistinct
    on QueryBuilder<RunResult, RunResult, QDistinct> {
  QueryBuilder<RunResult, RunResult, QDistinct> distinctByAvgPaceSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgPaceSeconds');
    });
  }

  QueryBuilder<RunResult, RunResult, QDistinct> distinctByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coins');
    });
  }

  QueryBuilder<RunResult, RunResult, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<RunResult, RunResult, QDistinct> distinctByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distance');
    });
  }

  QueryBuilder<RunResult, RunResult, QDistinct> distinctByKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kcal');
    });
  }

  QueryBuilder<RunResult, RunResult, QDistinct> distinctBySpeeds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speeds');
    });
  }

  QueryBuilder<RunResult, RunResult, QDistinct> distinctByTotalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSeconds');
    });
  }
}

extension RunResultQueryProperty
    on QueryBuilder<RunResult, RunResult, QQueryProperty> {
  QueryBuilder<RunResult, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RunResult, int?, QQueryOperations> avgPaceSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgPaceSeconds');
    });
  }

  QueryBuilder<RunResult, int?, QQueryOperations> coinsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coins');
    });
  }

  QueryBuilder<RunResult, DateTime?, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<RunResult, double?, QQueryOperations> distanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distance');
    });
  }

  QueryBuilder<RunResult, double?, QQueryOperations> kcalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kcal');
    });
  }

  QueryBuilder<RunResult, List<PointLatLng>?, QQueryOperations>
      pointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'points');
    });
  }

  QueryBuilder<RunResult, List<double>?, QQueryOperations> speedsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speeds');
    });
  }

  QueryBuilder<RunResult, int?, QQueryOperations> totalSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSeconds');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PointLatLngSchema = Schema(
  name: r'PointLatLng',
  id: 1540622016076584768,
  properties: {
    r'latitude': PropertySchema(
      id: 0,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 1,
      name: r'longitude',
      type: IsarType.double,
    )
  },
  estimateSize: _pointLatLngEstimateSize,
  serialize: _pointLatLngSerialize,
  deserialize: _pointLatLngDeserialize,
  deserializeProp: _pointLatLngDeserializeProp,
);

int _pointLatLngEstimateSize(
  PointLatLng object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pointLatLngSerialize(
  PointLatLng object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.latitude);
  writer.writeDouble(offsets[1], object.longitude);
}

PointLatLng _pointLatLngDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PointLatLng(
    latitude: reader.readDoubleOrNull(offsets[0]),
    longitude: reader.readDoubleOrNull(offsets[1]),
  );
  return object;
}

P _pointLatLngDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PointLatLngQueryFilter
    on QueryBuilder<PointLatLng, PointLatLng, QFilterCondition> {
  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition> latitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition> latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      longitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PointLatLng, PointLatLng, QAfterFilterCondition>
      longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PointLatLngQueryObject
    on QueryBuilder<PointLatLng, PointLatLng, QFilterCondition> {}
