// lib/data/models/classroom.dart
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'classroom.g.dart';

enum GradeLevel {
  @JsonValue('Kindergarten')
  kindergarten,
  @JsonValue('Primary')
  primary,
  @JsonValue('Secondary')
  secondary,
  @JsonValue('HighSchool')
  highSchool,
  @JsonValue('Preparatory')
  preparatory,
}

enum KgClassType {
  @JsonValue('Nursery')
  nursery,
  @JsonValue('LowerKg')
  lowerKg,
  @JsonValue('UpperKg')
  upperKg,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Classroom {
  final String id;
  final String schoolId;
  final String academicYearId;
  final String createdBy;
  final String displayName;
  final GradeLevel gradeLevel;
  final int? gradeNumber;
  final KgClassType? kgClassType;
  final int displayOrder;
  final int capacity;
  final DateTime createdAt;
  final DateTime updatedAt;

  Classroom({
    required this.id,
    required this.schoolId,
    required this.academicYearId,
    required this.createdBy,
    required this.displayName,
    required this.gradeLevel,
    this.gradeNumber,
    this.kgClassType,
    required this.displayOrder,
    required this.capacity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) =>
      _$ClassroomFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomToJson(this);

  bool get isKindergarten => gradeLevel == GradeLevel.kindergarten;
  String get gradeDisplay {
    if (isKindergarten) {
      switch (kgClassType) {
        case KgClassType.nursery:
          return 'Nursery';
        case KgClassType.lowerKg:
          return 'Lower KG';
        case KgClassType.upperKg:
          return 'Upper KG';
        default:
          return displayName;
      }
    }
    return displayName;
  }

  Color get color {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
      const Color(0xFFFFE66D),
      const Color(0xFFA8E6CF),
      const Color(0xFFFF8A5C),
      const Color(0xFF845EC2),
      const Color(0xFF0081CF),
      const Color(0xFF00C9A7),
      const Color(0xFFFF4C60),
    ];
    return colors[(displayOrder % colors.length)];
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateClassroomRequest {
  final String academicYearId;
  final GradeLevel gradeLevel;
  final int displayOrderOffset;
  final int capacity;
  final bool? createKgTypes;

  CreateClassroomRequest({
    required this.academicYearId,
    required this.gradeLevel,
    required this.displayOrderOffset,
    required this.capacity,
    this.createKgTypes,
  });

  factory CreateClassroomRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateClassroomRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateClassroomRequestToJson(this);
}
