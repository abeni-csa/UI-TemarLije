// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  schoolId: const UuidJsonConverter().fromJson(json['school_id'] as String),
  classroomId: const UuidJsonConverter().fromJson(
    json['classroom_id'] as String,
  ),
  roomTeacherId: _$JsonConverterFromJson<String, UuidValue>(
    json['room_teacher_id'],
    const UuidJsonConverter().fromJson,
  ),
  sectionName: json['section_name'] as String,
  sectionCode: json['section_code'] as String,
  capacity: (json['capacity'] as num).toInt(),
  currentEnrollment: (json['current_enrollment'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'school_id': const UuidJsonConverter().toJson(instance.schoolId),
  'classroom_id': const UuidJsonConverter().toJson(instance.classroomId),
  'room_teacher_id': _$JsonConverterToJson<String, UuidValue>(
    instance.roomTeacherId,
    const UuidJsonConverter().toJson,
  ),
  'section_name': instance.sectionName,
  'section_code': instance.sectionCode,
  'capacity': instance.capacity,
  'current_enrollment': instance.currentEnrollment,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

BulkSectionRequest _$BulkSectionRequestFromJson(Map<String, dynamic> json) =>
    BulkSectionRequest(
      schoolId: const UuidJsonConverter().fromJson(json['school_id'] as String),
      academicYearId: const UuidJsonConverter().fromJson(
        json['academic_year_id'] as String,
      ),
      sectionsPerClassroom: (json['sections_per_classroom'] as num).toInt(),
      namingPattern: NamingPattern.fromJson(
        json['naming_pattern'] as Map<String, dynamic>,
      ),
      roomTeacherIds: (json['room_teacher_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      defaultCapacity: (json['default_capacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BulkSectionRequestToJson(
  BulkSectionRequest instance,
) => <String, dynamic>{
  'school_id': const UuidJsonConverter().toJson(instance.schoolId),
  'academic_year_id': const UuidJsonConverter().toJson(instance.academicYearId),
  'sections_per_classroom': instance.sectionsPerClassroom,
  'naming_pattern': instance.namingPattern,
  'room_teacher_ids': instance.roomTeacherIds,
  'default_capacity': instance.defaultCapacity,
};

NamingPattern _$NamingPatternFromJson(Map<String, dynamic> json) =>
    NamingPattern(
      prefix: json['prefix'] as String,
      startIndex: (json['start_index'] as num).toInt(),
      suffix: json['suffix'] as String?,
    );

Map<String, dynamic> _$NamingPatternToJson(NamingPattern instance) =>
    <String, dynamic>{
      'prefix': instance.prefix,
      'start_index': instance.startIndex,
      'suffix': instance.suffix,
    };
