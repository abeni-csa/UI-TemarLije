import 'package:json_annotation/json_annotation.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';

part 'section.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Section {
  @UuidJsonConverter()
  final UuidValue id;
  @UuidJsonConverter()
  final UuidValue schoolId;
  @UuidJsonConverter()
  final UuidValue classroomId;
  @UuidJsonConverter()
  final UuidValue? roomTeacherId;
  final String sectionName;
  final String sectionCode;
  final int capacity;
  final int currentEnrollment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Section({
    required this.id,
    required this.schoolId,
    required this.classroomId,
    this.roomTeacherId,
    required this.sectionName,
    required this.sectionCode,
    required this.capacity,
    required this.currentEnrollment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);

  bool get hasCapacity => currentEnrollment < capacity;
  int get availableSeats => capacity - currentEnrollment;
  double get occupancyRate => capacity > 0 ? currentEnrollment / capacity : 0;
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class SectionRequest {
  @UuidJsonConverter()
  final UuidValue classroomId;
  final String sectionName;
  final int capacity;
  @UuidJsonConverter()
  final UuidValue? roomTeacherId;
  @UuidJsonConverter()
  final UuidValue academicYearId;
  SectionRequest({
    required this.classroomId,
    required this.sectionName,
    required this.capacity,
    this.roomTeacherId,
    required this.academicYearId,
  });

  factory SectionRequest.fromJson(Map<String, dynamic> json) =>
      _$SectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SectionRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BulkSectionRequest {
  @UuidJsonConverter()
  final UuidValue schoolId;
  @UuidJsonConverter()
  final UuidValue academicYearId;
  final int sectionsPerClassroom;
  final NamingPattern namingPattern;
  final List<String>? roomTeacherIds;
  final int? defaultCapacity;

  BulkSectionRequest({
    required this.schoolId,
    required this.academicYearId,
    required this.sectionsPerClassroom,
    required this.namingPattern,
    this.roomTeacherIds,
    this.defaultCapacity,
  });

  factory BulkSectionRequest.fromJson(Map<String, dynamic> json) =>
      _$BulkSectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BulkSectionRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NamingPattern {
  final String prefix;
  final int startIndex;
  final String? suffix;

  NamingPattern({required this.prefix, required this.startIndex, this.suffix});

  factory NamingPattern.fromJson(Map<String, dynamic> json) =>
      _$NamingPatternFromJson(json);

  Map<String, dynamic> toJson() => _$NamingPatternToJson(this);
}
