// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  schoolId: const UuidJsonConverter().fromJson(json['school_id'] as String),
  academicYearId: const UuidJsonConverter().fromJson(
    json['academic_year_id'] as String,
  ),
  name: json['name'] as String,
  code: json['code'] as String,
  description: json['description'] as String?,
  isCore: json['is_core'] as bool,
  isFieldBased: json['is_field_based'] as bool,
  weeklyPeriods: (json['weekly_periods'] as num).toInt(),
  teacherQualifications: (json['teacher_qualifications'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  educationLevels: (json['education_levels'] as List<dynamic>)
      .map((e) => $enumDecode(_$EducationLevelEnumMap, e))
      .toList(),
  streams: (json['streams'] as List<dynamic>)
      .map((e) => $enumDecode(_$SubjectTypeStreamEnumMap, e))
      .toList(),
  requiresSpecialRoom: json['requires_special_room'] as bool,
  roomType: $enumDecode(_$RoomTypeEnumMap, json['room_type']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'school_id': const UuidJsonConverter().toJson(instance.schoolId),
  'academic_year_id': const UuidJsonConverter().toJson(instance.academicYearId),
  'name': instance.name,
  'code': instance.code,
  'description': instance.description,
  'is_core': instance.isCore,
  'is_field_based': instance.isFieldBased,
  'weekly_periods': instance.weeklyPeriods,
  'teacher_qualifications': instance.teacherQualifications,
  'education_levels': instance.educationLevels
      .map((e) => _$EducationLevelEnumMap[e]!)
      .toList(),
  'streams': instance.streams
      .map((e) => _$SubjectTypeStreamEnumMap[e]!)
      .toList(),
  'requires_special_room': instance.requiresSpecialRoom,
  'room_type': _$RoomTypeEnumMap[instance.roomType]!,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$EducationLevelEnumMap = {
  EducationLevel.KG1: 'KG1',
  EducationLevel.KG2: 'KG2',
  EducationLevel.KG3: 'KG3',
  EducationLevel.Primary: 'Primary',
  EducationLevel.Middle: 'Middle',
  EducationLevel.Secondary9_10: 'Secondary9_10',
  EducationLevel.Secondary11_12: 'Secondary11_12',
};

const _$SubjectTypeStreamEnumMap = {
  SubjectTypeStream.SchoolSpecific: 'SchoolSpecific',
  SubjectTypeStream.FieldBased: 'FieldBased',
  SubjectTypeStream.Core: 'Core',
  SubjectTypeStream.NaturalScience: 'NaturalScience',
  SubjectTypeStream.SocialScience: 'SocialScience',
  SubjectTypeStream.Business: 'Business',
  SubjectTypeStream.Arts: 'Arts',
  SubjectTypeStream.Technology: 'Technology',
  SubjectTypeStream.Agriculture: 'Agriculture',
  SubjectTypeStream.HealthScience: 'HealthScience',
  SubjectTypeStream.General: 'General',
};

const _$RoomTypeEnumMap = {
  RoomType.Regular: 'Regular',
  RoomType.Laboratory: 'Laboratory',
  RoomType.ComputerLab: 'ComputerLab',
  RoomType.SportsField: 'SportsField',
};

CreateSubjectRequest _$CreateSubjectRequestFromJson(
  Map<String, dynamic> json,
) => CreateSubjectRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
  isCore: json['is_core'] as bool,
  isFieldBased: json['is_field_based'] as bool,
  weeklyPeriods: (json['weekly_periods'] as num).toInt(),
  teacherQualifications: (json['teacher_qualifications'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  educationLevels: (json['education_levels'] as List<dynamic>)
      .map((e) => $enumDecode(_$EducationLevelEnumMap, e))
      .toList(),
  streams: (json['streams'] as List<dynamic>)
      .map((e) => $enumDecode(_$SubjectTypeStreamEnumMap, e))
      .toList(),
  requiresSpecialRoom: json['requires_special_room'] as bool,
  roomType: $enumDecode(_$RoomTypeEnumMap, json['room_type']),
);

Map<String, dynamic> _$CreateSubjectRequestToJson(
  CreateSubjectRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'is_core': instance.isCore,
  'is_field_based': instance.isFieldBased,
  'weekly_periods': instance.weeklyPeriods,
  'teacher_qualifications': instance.teacherQualifications,
  'education_levels': instance.educationLevels
      .map((e) => _$EducationLevelEnumMap[e]!)
      .toList(),
  'streams': instance.streams
      .map((e) => _$SubjectTypeStreamEnumMap[e]!)
      .toList(),
  'requires_special_room': instance.requiresSpecialRoom,
  'room_type': _$RoomTypeEnumMap[instance.roomType]!,
};

UpdateSubjectRequest _$UpdateSubjectRequestFromJson(
  Map<String, dynamic> json,
) => UpdateSubjectRequest(
  subjectName: json['subject_name'] as String?,
  subjectCode: json['subject_code'] as String?,
  description: json['description'] as String?,
  isCore: json['is_core'] as bool?,
  isFieldBased: json['is_field_based'] as bool?,
  weeklyPeriods: (json['weekly_periods'] as num?)?.toInt(),
  teacherQualifications: (json['teacher_qualifications'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  educationLevels: (json['education_levels'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$EducationLevelEnumMap, e))
      .toList(),
  streams: (json['streams'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$SubjectTypeStreamEnumMap, e))
      .toList(),
  requiresSpecialRoom: json['requires_special_room'] as bool?,
  roomType: $enumDecodeNullable(_$RoomTypeEnumMap, json['room_type']),
);

Map<String, dynamic> _$UpdateSubjectRequestToJson(
  UpdateSubjectRequest instance,
) => <String, dynamic>{
  'subject_name': instance.subjectName,
  'subject_code': instance.subjectCode,
  'description': instance.description,
  'is_core': instance.isCore,
  'is_field_based': instance.isFieldBased,
  'weekly_periods': instance.weeklyPeriods,
  'teacher_qualifications': instance.teacherQualifications,
  'education_levels': instance.educationLevels
      ?.map((e) => _$EducationLevelEnumMap[e]!)
      .toList(),
  'streams': instance.streams
      ?.map((e) => _$SubjectTypeStreamEnumMap[e]!)
      .toList(),
  'requires_special_room': instance.requiresSpecialRoom,
  'room_type': _$RoomTypeEnumMap[instance.roomType],
};
