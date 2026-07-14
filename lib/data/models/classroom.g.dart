// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classroom _$ClassroomFromJson(Map<String, dynamic> json) => Classroom(
  id: json['id'] as String,
  schoolId: json['school_id'] as String,
  academicYearId: json['academic_year_id'] as String,
  createdBy: json['created_by'] as String,
  displayName: json['display_name'] as String,
  gradeLevel: $enumDecode(_$GradeLevelEnumMap, json['grade_level']),
  gradeNumber: (json['grade_number'] as num?)?.toInt(),
  kgClassType: $enumDecodeNullable(_$KgClassTypeEnumMap, json['kg_class_type']),
  displayOrder: (json['display_order'] as num).toInt(),
  capacity: (json['capacity'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ClassroomToJson(Classroom instance) => <String, dynamic>{
  'id': instance.id,
  'school_id': instance.schoolId,
  'academic_year_id': instance.academicYearId,
  'created_by': instance.createdBy,
  'display_name': instance.displayName,
  'grade_level': _$GradeLevelEnumMap[instance.gradeLevel]!,
  'grade_number': instance.gradeNumber,
  'kg_class_type': _$KgClassTypeEnumMap[instance.kgClassType],
  'display_order': instance.displayOrder,
  'capacity': instance.capacity,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$GradeLevelEnumMap = {
  GradeLevel.kindergarten: 'Kindergarten',
  GradeLevel.primary: 'Primary',
  GradeLevel.secondary: 'Secondary',
  GradeLevel.highSchool: 'HighSchool',
  GradeLevel.preparatory: 'Preparatory',
};

const _$KgClassTypeEnumMap = {
  KgClassType.nursery: 'Nursery',
  KgClassType.lowerKg: 'LowerKg',
  KgClassType.upperKg: 'UpperKg',
};

CreateClassroomRequest _$CreateClassroomRequestFromJson(
  Map<String, dynamic> json,
) => CreateClassroomRequest(
  academicYearId: json['academic_year_id'] as String,
  gradeLevel: $enumDecode(_$GradeLevelEnumMap, json['grade_level']),
  displayOrderOffset: (json['display_order_offset'] as num).toInt(),
  capacity: (json['capacity'] as num).toInt(),
  createKgTypes: json['create_kg_types'] as bool?,
);

Map<String, dynamic> _$CreateClassroomRequestToJson(
  CreateClassroomRequest instance,
) => <String, dynamic>{
  'academic_year_id': instance.academicYearId,
  'grade_level': _$GradeLevelEnumMap[instance.gradeLevel]!,
  'display_order_offset': instance.displayOrderOffset,
  'capacity': instance.capacity,
  'create_kg_types': instance.createKgTypes,
};
