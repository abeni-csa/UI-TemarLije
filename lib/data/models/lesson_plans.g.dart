// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_plans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonPlan _$LessonPlanFromJson(Map<String, dynamic> json) => LessonPlan(
  id: json['id'] as String,
  title: json['title'] as String,
  gradeLevel: json['grade_level'] as String,
  subject: json['subject'] as String,
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  isDeleted: json['is_deleted'] == null
      ? false
      : LessonPlan._boolFromInt((json['is_deleted'] as num).toInt()),
  version: (json['version'] as num?)?.toInt() ?? 1,
  lastSyncedAt: json['last_synced_at'] == null
      ? null
      : DateTime.parse(json['last_synced_at'] as String),
);

Map<String, dynamic> _$LessonPlanToJson(LessonPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subject': instance.subject,
      'grade_level': instance.gradeLevel,
      'duration_minutes': instance.durationMinutes,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'last_synced_at': instance.lastSyncedAt?.toIso8601String(),
      'is_deleted': LessonPlan._boolToInt(instance.isDeleted),
      'version': instance.version,
    };

const _$LessonPlanJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'string'},
    'title': {'type': 'string'},
    'subject': {'type': 'string'},
    'grade_level': {'type': 'string'},
    'duration_minutes': {'type': 'integer'},
    'updated_at': {'type': 'string', 'format': 'date-time'},
    'created_at': {'type': 'string', 'format': 'date-time'},
    'last_synced_at': {'type': 'string', 'format': 'date-time'},
    'is_deleted': {'type': 'boolean', 'default': false},
    'version': {'type': 'integer', 'default': 1},
  },
  'required': [
    'id',
    'title',
    'subject',
    'grade_level',
    'duration_minutes',
    'updated_at',
    'created_at',
  ],
};
