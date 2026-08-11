import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'subject.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class Subject {
  @UuidJsonConverter()
  final UuidValue id;
  @UuidJsonConverter()
  final UuidValue schoolId;
  @UuidJsonConverter()
  final UuidValue academicYearId;
  final String name;
  final String code;
  final String? description;
  final bool isCore;
  final bool isFieldBased;
  final int weeklyPeriods;
  final List<String> teacherQualifications;

  final List<EducationLevel> educationLevels;
  final List<SubjectTypeStream> streams;
  final bool requiresSpecialRoom;
  final RoomType roomType;
  final DateTime createdAt;
  final DateTime updatedAt;
  Subject({
    required this.id,
    required this.schoolId,
    required this.academicYearId,
    required this.name,
    required this.code,
    this.description,

    required this.isCore,

    required this.isFieldBased,

    required this.weeklyPeriods,

    required this.teacherQualifications,

    required this.educationLevels,

    required this.streams,

    required this.requiresSpecialRoom,

    required this.roomType,

    required this.createdAt,
    required this.updatedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class CreateSubjectRequest {
  final String name;
  // final String code;
  final String? description;
  final bool isCore;
  final bool isFieldBased;
  final int weeklyPeriods;
  final List<String> teacherQualifications;
  final List<EducationLevel> educationLevels;
  final List<SubjectTypeStream> streams;
  final bool requiresSpecialRoom;
  final RoomType roomType;
  CreateSubjectRequest({
    required this.name,
    this.description,
    required this.isCore,

    required this.isFieldBased,

    required this.weeklyPeriods,

    required this.teacherQualifications,

    required this.educationLevels,

    required this.streams,

    required this.requiresSpecialRoom,

    required this.roomType,
  });

  factory CreateSubjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSubjectRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateSubjectRequestToJson(this);
}

// Add this to subject.dart after CreateSubjectRequest

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class UpdateSubjectRequest {
  final String? subjectName;
  final String? subjectCode;
  final String? description;
  final bool? isCore;
  final bool? isFieldBased;
  final int? weeklyPeriods;
  final List<String>? teacherQualifications;
  final List<EducationLevel>? educationLevels;
  final List<SubjectTypeStream>? streams;
  final bool? requiresSpecialRoom;
  final RoomType? roomType;

  UpdateSubjectRequest({
    this.subjectName,
    this.subjectCode,
    this.description,
    this.isCore,
    this.isFieldBased,
    this.weeklyPeriods,
    this.teacherQualifications,
    this.educationLevels,
    this.streams,
    this.requiresSpecialRoom,
    this.roomType,
  });

  factory UpdateSubjectRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSubjectRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSubjectRequestToJson(this);
}
// /// DTO for updating a subject
// #[derive(Debug, Clone, Deserialize, Validate)]
// pub struct UpdateSubjectRequest {
//     pub subject_name: Option<String>,
//     pub subject_code: Option<String>,
//     pub description: Option<String>,
//     pub max_score: Option<f64>,
//     pub is_core: Option<bool>,
//     pub is_field_based: Option<bool>,
//     pub weekly_periods: Option<i32>,
//     pub teacher_qualifications: Option<Vec<String>>,
//     pub education_levels: Option<Vec<EducationLevel>>,
//     pub streams: Option<Vec<SubjectTypeStream>>,
//     pub requires_special_room: Option<bool>,
//     pub room_type: Option<RoomType>,
// }

// /// Teacher-Subject assignment model
// #[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
// pub struct TeacherSubjectAssignment {
//     pub id: Uuid,
//     pub teacher_id: Uuid,
//     pub subject_id: Uuid,
//     pub school_id: Uuid,
//     pub academic_year_id: Uuid,
//     pub assigned_at: DateTime<Utc>,
// }

// /// DTO for assigning a teacher to a subject
// #[derive(Debug, Clone, Deserialize)]
// pub struct AssignTeacherToSubjectRequest {
//     pub teacher_id: Uuid,
//     pub academic_year_id: Uuid,
// }

// /// DTO for subject with teacher assignments
// #[derive(Debug, Clone, Serialize)]
// pub struct SubjectWithTeachers {
//     pub subject: Subject,
//     pub teachers: Vec<TeacherSubjectAssignment>,
// }
