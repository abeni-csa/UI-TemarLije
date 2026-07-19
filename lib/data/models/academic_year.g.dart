// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicYear _$AcademicYearFromJson(Map<String, dynamic> json) => AcademicYear(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  schoolId: json['school_id'] as String,
  yearRange: json['year_range'] as String,
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  isCurrent: json['is_current'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$AcademicYearToJson(AcademicYear instance) =>
    <String, dynamic>{
      'id': const UuidJsonConverter().toJson(instance.id),
      'school_id': instance.schoolId,
      'year_range': instance.yearRange,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'is_current': instance.isCurrent,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

AcademicYearListResponse _$AcademicYearListResponseFromJson(
  Map<String, dynamic> json,
) => AcademicYearListResponse(
  academicYears: (json['academic_years'] as List<dynamic>)
      .map((e) => AcademicYear.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  currentAcademicYear: json['current_academic_year'] == null
      ? null
      : AcademicYear.fromJson(
          json['current_academic_year'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AcademicYearListResponseToJson(
  AcademicYearListResponse instance,
) => <String, dynamic>{
  'academic_years': instance.academicYears,
  'total': instance.total,
  'current_academic_year': instance.currentAcademicYear,
};

CreateAcademicYearRequest _$CreateAcademicYearRequestFromJson(
  Map<String, dynamic> json,
) => CreateAcademicYearRequest(
  yearRange: json['year_range'] as String,
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String,
  isCurrent: json['is_current'] as bool,
);

Map<String, dynamic> _$CreateAcademicYearRequestToJson(
  CreateAcademicYearRequest instance,
) => <String, dynamic>{
  'year_range': instance.yearRange,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'is_current': instance.isCurrent,
};

UpdateAcademicYearRequest _$UpdateAcademicYearRequestFromJson(
  Map<String, dynamic> json,
) => UpdateAcademicYearRequest(
  yearRange: json['year_range'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  isCurrent: json['is_current'] as bool?,
);

Map<String, dynamic> _$UpdateAcademicYearRequestToJson(
  UpdateAcademicYearRequest instance,
) => <String, dynamic>{
  'year_range': instance.yearRange,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'is_current': instance.isCurrent,
};
