import 'package:json_annotation/json_annotation.dart';
part 'lesson_plans.g.dart';

@JsonSerializable(
  createJsonSchema: true,
  fieldRename: FieldRename.snake,
  createFactory: true,
)
class LessonPlan {
  final String id, title, subject, gradeLevel;
  final int durationMinutes;
  final DateTime updatedAt, createdAt;
  final DateTime? lastSyncedAt;
  @JsonKey(fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isDeleted;

  final int version;

  const LessonPlan({
    required this.id,
    required this.title,
    required this.gradeLevel,
    required this.subject,
    required this.durationMinutes,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.version = 1,
    this.lastSyncedAt,
  });

  factory LessonPlan.create({
    required String title,
    required String subject,
    required String gradeLevel,
    required int durationMinutes,
    String? id,
  }) {
    final now = DateTime.now();
    return LessonPlan(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      subject: subject,
      gradeLevel: gradeLevel,
      durationMinutes: durationMinutes,
      createdAt: now,
      updatedAt: now,
    );
  }

  LessonPlan copyWith({
    String? title,
    String? subject,
    String? gradeLevel,
    int? durationMinutes,
    DateTime? updatedAt,
    DateTime? createdAt,
    DateTime? lastSyncedAt,
    bool? isDeleted,
    int? version,
  }) {
    return LessonPlan(
      id: id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? (this.version + 1),
    );
  }

  // JSON serialization
  factory LessonPlan.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanFromJson(json);

  Map<String, dynamic> toJson() => _$LessonPlanToJson(this);

  // SQLite mapping
  Map<String, dynamic> toMap() => toJson();
  factory LessonPlan.fromMap(Map<String, dynamic> map) =>
      _$LessonPlanFromJson(map);

  static bool _boolFromInt(int value) => value == 1;
  static int _boolToInt(bool value) => value ? 1 : 0;
}

class LessonObjectives {
  // ## LessonObjectives

  // * id: BIGINT (Primary Key).
  // * lesson_id: UUID or BIGINT (Foreign Key). Links to LessonPlans.
  // * objective_text: TEXT. Long-form text describing a specific learning goal.
}

class LessonFlow {
  // ## LessonFlow (The Timeline Grid)

  // * id: BIGINT (Primary Key).
  // * lesson_id: UUID or BIGINT (Foreign Key). Links to LessonPlans.
  // * phase_name: VARCHAR(100). Name of the section (e.g., "Introduction", "Coding Practice").
  // * duration_minutes: INT. Time allocated for this specific step.
  // * description: TEXT. Detailed teaching instructions and activities.
  // * order_index: INT. Controls the display sequence (1, 2, 3...) of the timeline steps.
}

class Materials {
  // * id: BIGINT (Primary Key).
  // * lesson_id: UUID or BIGINT (Foreign Key). Links to LessonPlans.
  // * resource_type: VARCHAR(50). Defines the type (e.g., "Link", "File", "Text").
  // * resource_url: VARCHAR(2048). Standard long string length to hold web or file upload paths.
}
