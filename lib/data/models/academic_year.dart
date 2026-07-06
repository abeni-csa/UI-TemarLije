import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'academic_year.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AcademicYear extends Equatable {
  final String id;
  final String schoolId;
  final String yearRange;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCurrent;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AcademicYear({
    required this.id,
    required this.schoolId,
    required this.yearRange,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcademicYear.fromJson(Map<String, dynamic> json) =>
      _$AcademicYearFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicYearToJson(this);

  @override
  List<Object?> get props => [
    id,
    schoolId,
    yearRange,
    startDate,
    endDate,
    isCurrent,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AcademicYearListResponse {
  final List<AcademicYear> academicYears;
  final int total;
  final AcademicYear? currentAcademicYear;

  const AcademicYearListResponse({
    required this.academicYears,
    required this.total,
    this.currentAcademicYear,
  });

  factory AcademicYearListResponse.fromJson(Map<String, dynamic> json) =>
      _$AcademicYearListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicYearListResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateAcademicYearRequest {
  final String yearRange;
  final String startDate;
  final String endDate;
  final bool isCurrent;

  const CreateAcademicYearRequest({
    required this.yearRange,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
  });

  Map<String, dynamic> toJson() => _$CreateAcademicYearRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateAcademicYearRequest {
  final String? yearRange;
  final String? startDate;
  final String? endDate;
  final bool? isCurrent;

  const UpdateAcademicYearRequest({
    this.yearRange,
    this.startDate,
    this.endDate,
    this.isCurrent,
  });

  Map<String, dynamic> toJson() => _$UpdateAcademicYearRequestToJson(this);
}
