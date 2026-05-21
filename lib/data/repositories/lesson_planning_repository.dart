import 'package:sqflite/sqflite.dart';
import 'package:ui_temarlije/data/models/conflict_resolution.dart';
import 'package:ui_temarlije/data/models/lesson_plans.dart';
import 'package:ui_temarlije/service/database_service.dart';

class LessonPlanningRepository {
  final LocalDatabaseService _databaseHelper = LocalDatabaseService();
  static const String _tableName = 'lesson_plan';

  // Create a new note
  Future<LessonPlan> createLessonPlan(LessonPlan note) async {
    try {
      final db = await _databaseHelper.database;
      await db.insert(
        _tableName,
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      return note;
    } catch (e) {
      throw LessonRepositoryException('Failed to create note: $e');
    }
  }

  // Get all notes (excluding deleted ones by default)
  Future<List<LessonPlan>> getAllLessonPlans({
    bool includeDeleted = false,
  }) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: includeDeleted ? null : 'is_deleted = ?',
        whereArgs: includeDeleted ? null : [0],
        orderBy: 'updated_at DESC',
      );

      return maps.map((map) => LessonPlan.fromMap(map)).toList();
    } catch (e) {
      throw LessonRepositoryException('Failed to get notes: $e');
    }
  }

  // Get a specific note by ID
  Future<LessonPlan?> getLessonPlanById(String id) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'id = ? AND is_deleted = ?',
        whereArgs: [id, 0],
        limit: 1,
      );

      if (maps.isEmpty) return null;
      return LessonPlan.fromMap(maps.first);
    } catch (e) {
      throw LessonRepositoryException('Failed to get note: $e');
    }
  }

  // Update an existing note
  Future<LessonPlan> updateLessonPlan(LessonPlan note) async {
    try {
      final db = await _databaseHelper.database;
      final updatedLessonPlan = note.copyWith(updatedAt: DateTime.now());

      final rowsAffected = await db.update(
        _tableName,
        updatedLessonPlan.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      if (rowsAffected == 0) {
        throw LessonRepositoryException('LessonPlan not found for update');
      }

      return updatedLessonPlan;
    } catch (e) {
      throw LessonRepositoryException('Failed to update note: $e');
    }
  }

  // Soft delete a note (mark as deleted instead of removing)
  Future<void> deleteLessonPlan(String id) async {
    try {
      final db = await _databaseHelper.database;
      final rowsAffected = await db.update(
        _tableName,
        {'is_deleted': 1, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [id],
      );

      if (rowsAffected == 0) {
        throw LessonRepositoryException('LessonPlan not found for deletion');
      }
    } catch (e) {
      throw LessonRepositoryException('Failed to delete note: $e');
    }
  }

  Future<LessonPlan> upsertLessonPlan(
    LessonPlan note, {
    ConflictResolutionStrategy? strategy,
  }) async {
    try {
      final existingLessonPlan = await getLessonPlanById(note.id);

      if (existingLessonPlan == null) {
        // LessonPlan doesn't exist locally, create it
        return await createLessonPlan(note);
      }

      // Check for conflicts
      if (ConflictResolution.hasConflict(existingLessonPlan, note)) {
        final resolution = ConflictResolution(
          localVersion: existingLessonPlan,
          remoteVersion: note,
          strategy: strategy ?? ConflictResolutionStrategy.lastWriteWins,
        );

        final resolvedLessonPlan = resolution.resolve();
        return await updateLessonPlan(resolvedLessonPlan);
      } else {
        // No conflict, update normally
        return await updateLessonPlan(note);
      }
    } catch (e) {
      throw LessonRepositoryException('Failed to upsert note: $e');
    }
  } // Get notes that need to be synced (modified after last sync)

  Future<List<LessonPlan>> getUnsyncedLessonPlans() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'last_synced_at IS NULL OR updated_at > last_synced_at',
      );

      return maps.map((map) => LessonPlan.fromMap(map)).toList();
    } catch (e) {
      throw LessonRepositoryException('Failed to get unsynced notes: $e');
    }
  }

  // Update sync status for a note
  Future<void> markAsSynced(String id) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        _tableName,
        {'last_synced_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw LessonRepositoryException('Failed to mark note as synced: $e');
    }
  }
}

// Custom exception for repository operations
class LessonRepositoryException implements Exception {
  final String message;
  LessonRepositoryException(this.message);

  @override
  String toString() => 'RepositoryException: $message';
}
