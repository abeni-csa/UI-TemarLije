// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
  id: json['id'] as String,
  schoolId: json['school_id'] as String,
  classroomId: json['classroom_id'] as String,
  roomTeacherId: json['room_teacher_id'] as String?,
  sectionName: json['section_name'] as String,
  sectionCode: json['section_code'] as String,
  capacity: (json['capacity'] as num).toInt(),
  currentEnrollment: (json['current_enrollment'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
  'id': instance.id,
  'school_id': instance.schoolId,
  'classroom_id': instance.classroomId,
  'room_teacher_id': instance.roomTeacherId,
  'section_name': instance.sectionName,
  'section_code': instance.sectionCode,
  'capacity': instance.capacity,
  'current_enrollment': instance.currentEnrollment,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

BulkSectionRequest _$BulkSectionRequestFromJson(Map<String, dynamic> json) =>
    BulkSectionRequest(
      schoolId: json['school_id'] as String,
      academicYearId: json['academic_year_id'] as String,
      sectionsPerClassroom: (json['sections_per_classroom'] as num).toInt(),
      namingPattern: NamingPattern.fromJson(
        json['naming_pattern'] as Map<String, dynamic>,
      ),
      roomTeacherIds: (json['room_teacher_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      defaultCapacity: (json['default_capacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BulkSectionRequestToJson(BulkSectionRequest instance) =>
    <String, dynamic>{
      'school_id': instance.schoolId,
      'academic_year_id': instance.academicYearId,
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
